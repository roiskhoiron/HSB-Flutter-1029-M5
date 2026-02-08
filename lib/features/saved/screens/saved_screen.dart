import 'package:flutter/material.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.nav_saved)),
      body: Center(child: Text(loc.comingSoon(loc.nav_saved))),
    );
  }
}
