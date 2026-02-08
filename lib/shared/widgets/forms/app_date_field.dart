import 'package:flutter/material.dart';
import 'package:travel_planner/core/utils/app_date_utils.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const AppDateField({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AppTextField(
      controller: TextEditingController(
        text: date != null ? AppDateUtils.formatFormFieldDate(date!) : '',
      ),
      label: label,
      hint: loc.selectDate,
      prefixIcon: Icons.calendar_today,
      onTap: onTap,
    );
  }
}
