import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/shared/widgets/forms/app_date_field.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/result/result_handler.dart';

class TripForm extends StatefulWidget {
  final Trip? trip;
  final Function(Map<String, dynamic>) onSave;

  const TripForm({super.key, this.trip, required this.onSave});

  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _destinationController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TripStatus _status = TripStatus.planned;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.trip != null) {
      _titleController.text = widget.trip!.title;
      _descriptionController.text = widget.trip!.description;
      _destinationController.text = widget.trip!.destination.value;
      _budgetController.text = widget.trip!.budget.amountString;
      _startDate = widget.trip!.startDate.value;
      _endDate = widget.trip!.endDate.value;
      _status = widget.trip!.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trip == null ? loc.addNewTrip : loc.editTrip,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _titleController,
                  label: loc.tripTitle,
                  hint: loc.enterTripTitle,
                  prefixIcon: Icons.title,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return loc.errors_requiredField;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _descriptionController,
                  label: loc.description,
                  hint: loc.enterTripDescription,
                  prefixIcon: Icons.description,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _destinationController,
                  label: loc.destination,
                  hint: loc.enterDestination,
                  prefixIcon: Icons.place,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return loc.errors_requiredField;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppDateField(
                        label: loc.startDate,
                        date: _startDate,
                        onTap: () => _selectDate(context, true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppDateField(
                        label: loc.endDate,
                        date: _endDate,
                        onTap: () => _selectDate(context, false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _budgetController,
                  label: loc.budget,
                  hint: '0.00',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return loc.errors_requiredField;
                    }
                    if (double.tryParse(v) == null) {
                      return loc.pleaseEnterValidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<TripStatus>(
                  initialValue: _status,
                  decoration: InputDecoration(
                    labelText: loc.status,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: TripStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(_statusLabel(s, loc)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => _status = v);
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: loc.cancel,
                        variant: AppButtonVariant.primary,
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        text: widget.trip == null
                            ? loc.addTrip
                            : loc.updateTrip,
                        isLoading: _isLoading,
                        onPressed: _saveTrip,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(TripStatus s, AppLocalizations loc) => switch (s) {
    TripStatus.planned => loc.planned,
    TripStatus.upcoming => loc.ongoing,
    TripStatus.completed => loc.completed,
  };

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _saveTrip() async {
    if (!_formKey.currentState!.validate()) return;
    final loc = AppLocalizations.of(context);
    if (_startDate == null || _endDate == null) {
      ResultHandler.showErrorToast(context, loc.toast_selectBothDates);
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      ResultHandler.showErrorToast(context, loc.toast_endDateAfterStart);
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.onSave({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'destination': _destinationController.text,
        'startDate': _startDate!,
        'endDate': _endDate!,
        'budget': double.parse(_budgetController.text),
        'status': _status,
      });
      if (mounted) {
        ResultHandler.showSuccessToast(
          context,
          widget.trip == null ? loc.toast_tripCreated : loc.toast_tripCreated,
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ResultHandler.showErrorToast(
          context,
          loc.toast_tripError(e.toString()),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
