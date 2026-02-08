import 'package:flutter/material.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.nav_explore)),
      body: Center(child: Text(loc.comingSoon(loc.nav_explore))),
    );
  }
}
