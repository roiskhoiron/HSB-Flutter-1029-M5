import 'package:flutter/material.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/language_switch.dart';
import 'package:travel_planner/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:travel_planner/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:travel_planner/shared/widgets/app_tab_bar.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        //{Inline Review: Hindari refresh manual via setState jika perubahan sudah datang dari provider Riverpod.}
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  AppTabBar(
                    controller: _tabController,
                    currentIndex: _tabController.index,
                    tabs: [
                      context.l10n.action_sign_in,
                      context.l10n.action_sign_up,
                    ],
                    onTap: (index) => _tabController.animateTo(index),
                  ),
                  const SizedBox(height: 12),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface.withValues(
                          alpha: 0.85,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: IndexedStack(
                        index: _tabController.index,
                        children: const [SignInForm(), SignUpForm()],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildBottomActions(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ThemeSwitch(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: 1,
            height: 16,
            color: context.colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        const LanguageSwitch(),
      ],
    );
  }
}
