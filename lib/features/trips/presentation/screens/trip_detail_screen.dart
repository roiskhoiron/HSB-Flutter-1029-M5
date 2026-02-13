import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';

// 💎 Detail screen yang kaya fitur! Penggunaan `CustomScrollView` dengan 
// `SliverAppBar` memberikan pengalaman visual yang sangat premium. Level Pro! 🎨🏰
class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsState = ref.watch(tripsProvider);
    final tripNotifier = ref.read(tripsProvider.notifier);

    ref.listen<AsyncValue<void>>(tripOperationProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          if (prev?.isLoading == true) {
            // If the trip is gone from the list, we should be finishing navigation
            final trips = ref.read(tripsProvider).value ?? [];
            final exists = trips.any((t) => t.id == tripId);

            if (!exists) {
              ResultHandler.showSuccessToast(
                context,
                context.l10n.action_delete_trip,
              );
              if (context.mounted && context.canPop()) context.pop();
            }
          }
        },
        error: (err, _) =>
            ResultHandler.showErrorToast(context, err.toString()),
      );
    });

    return tripsState.when(
      loading: () => Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(child: Text('Error: $err')),
      ),
      data: (trips) {
        final tripIndex = trips.indexWhere((t) => t.id == tripId);

        if (tripIndex == -1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted && context.canPop()) {
              context.pop();
            }
          });
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final trip = trips[tripIndex];

        return Stack(
          children: [
            const Positioned.fill(
              child: AppBackgroundGradient(
                direction: GradientDirection.topToBottom,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    surfaceTintColor: Colors.transparent,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => context.pop(),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => TripDialogs.showEditTripDialog(
                          context,
                          trip,
                          tripNotifier.updateTrip,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => TripDialogs.showDeleteConfirmation(
                          context,
                          trip,
                          tripNotifier.deleteTrip,
                          isOnDetailScreen: true,
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      centerTitle: true,
                      title: Text(
                        trip.title,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoCard(
                            context,
                            icon: Icons.place_outlined,
                            title: context.l10n.label_destination,
                            value: trip.destination.value,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.calendar_today_outlined,
                                  title: context.l10n.label_start_date,
                                  value: DateFormat.yMMMd().format(
                                    trip.startDate.value,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.event_outlined,
                                  title: context.l10n.label_end_date,
                                  value: DateFormat.yMMMd().format(
                                    trip.endDate.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoCard(
                            context,
                            icon: Icons.attach_money_outlined,
                            title: context.l10n.label_budget,
                            value: '\$${trip.budget.amountString}',
                          ),
                          const SizedBox(height: 16),
                          _buildInfoCard(
                            context,
                            icon: Icons.info_outline,
                            title: context.l10n.label_status,
                            value: _getStatusLabel(trip.status, context.l10n),
                            statusColor: _getStatusColor(trip.status, context),
                          ),
                          if (trip.description.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            _buildDescriptionCard(context, trip.description),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    Color? statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: context.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: statusColor ?? context.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: context.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.label_description,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(dynamic status, AppLocalizations loc) {
    return switch (status.toString().split('.').last) {
      'planned' => loc.label_status_planned,
      'upcoming' => loc.label_status_ongoing,
      'completed' => loc.label_status_completed,
      _ => loc.label_status_planned,
    };
  }

  Color _getStatusColor(dynamic status, BuildContext context) {
    return switch (status.toString().split('.').last) {
      'planned' => context.colorScheme.primary,
      'upcoming' => Colors.orange,
      'completed' => Colors.green,
      _ => context.colorScheme.primary,
    };
  }
}
