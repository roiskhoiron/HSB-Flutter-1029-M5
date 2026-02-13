import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/router/app_routes.dart';

// 💎 `AppShell` dengan glassmorphism design (BackdropFilter) memberikan 
// tampilan yang sangat premium dan modern. Visual estetika tingkat tinggi! 💎✨
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _calculateSelectedIndex(location);

    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavBarItem(
                  icon: Icons.home_rounded,
                  isSelected: currentIndex == 0,
                  onTap: () => _onItemTapped(context, 0),
                ),
                _NavBarItem(
                  icon: Icons.public_rounded,
                  isSelected: currentIndex == 2,
                  onTap: () => _onItemTapped(context, 2),
                ),
                _NavBarItem(
                  icon: Icons.checklist_rounded,
                  isSelected: currentIndex == 3,
                  onTap: () => _onItemTapped(context, 3),
                ),
                _NavBarItem(
                  icon: Icons.settings_rounded,
                  isSelected: currentIndex == 1,
                  onTap: () => _onItemTapped(context, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/settings') || location.startsWith('/profile')) {
      return 1;
    }
    if (location.startsWith('/trips')) return 2;
    if (location.startsWith('/lists')) return 3;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        context.goNamed(AppRoutes.settings);
        break;
      case 2:
        context.goNamed(AppRoutes.trips);
        break;
      case 3:
        context.goNamed(AppRoutes.lists);
        break;
    }
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colorScheme.primary;
    final inactiveColor = context.colorScheme.onSurface.withValues(alpha: 0.4);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: widget.isSelected ? 48 : 0,
              height: 48,
              decoration: BoxDecoration(
                color: activeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Icon(
              widget.icon,
              color: widget.isSelected ? activeColor : inactiveColor,
              size: 26,
            ),
            if (widget.isSelected)
              Positioned(
                bottom: 6,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
