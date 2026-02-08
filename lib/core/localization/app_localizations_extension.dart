import 'package:travel_planner/generated/l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String getTripStatusTranslation(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return tripStatusPlanned;
      case 'ongoing':
        return tripStatusOngoing;
      case 'completed':
        return tripStatusCompleted;
      case 'cancelled':
        return tripStatusCancelled;
      default:
        return status;
    }
  }
}
