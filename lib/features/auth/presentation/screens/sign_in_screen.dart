import 'package:flutter/material.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/language_switch.dart';
import 'package:travel_planner/features/auth/presentation/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: AppBackgroundGradient(type: GradientType.bottomUp),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopActions(),
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [SizedBox(height: 20), SignInForm()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopActions() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ActionToggleContainer(child: ThemeSwitch()),
          SizedBox(width: 12),
          _ActionToggleContainer(child: LanguageSwitch()),
        ],
      ),
    );
  }
}

class _ActionToggleContainer extends StatelessWidget {
  final Widget child;
  const _ActionToggleContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
