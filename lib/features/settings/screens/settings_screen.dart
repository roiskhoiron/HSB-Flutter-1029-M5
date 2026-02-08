import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/app_tab_bar.dart';
import 'package:travel_planner/features/settings/presentation/widgets/profile_tab.dart';
import 'package:travel_planner/features/settings/presentation/widgets/preferences_tab.dart';
import 'package:travel_planner/features/settings/presentation/widgets/account_tab.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () => context.goNamed(AppRoutes.home),
        ),
        title: Text(
          context.l10n.settings,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: context.colorScheme.onSurface,
          size: 24,
        ),
        bottom: AppTabBar(
          controller: _tabController,
          currentIndex: _currentTab,
          tabs: [
            context.l10n.tab_profile,
            context.l10n.tab_preferences,
            context.l10n.tab_account,
          ],
          onTap: (index) => _tabController.animateTo(index),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ProfileTab(), PreferencesTab(), AccountTab()],
      ),
    );
  }
}
