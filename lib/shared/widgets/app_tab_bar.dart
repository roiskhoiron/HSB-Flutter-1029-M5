import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final List<String> tabs;
  final Function(int) onTap;
  final TabController? controller;

  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: tabs
          .map(
            (tab) => Tab(
              child: Text(
                tab.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
          .toList(),
      indicatorColor: theme.colorScheme.primary,
      indicatorWeight: 3,
      labelColor: theme.colorScheme.primary,
      unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.5),
      labelStyle: const TextStyle(fontSize: 12),
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
