import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/features/auth/presentation/widgets/auth_header.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _isLoading = true);
    try {
      final authProvider = context.read<AuthProvider>();
      final loc = AppLocalizations.of(context);

      await authProvider.login(_emailController.text, _passwordController.text);

      if (!mounted) return;

      if (authProvider.currentUser != null) {
        ResultHandler.showSuccessToast(context, loc.toast_welcomeBack);
        context.goNamed(AppRoutes.home);
      } else if (authProvider.error != null) {
        ResultHandler.showErrorToast(context, authProvider.error!);
      }
    } catch (e) {
      if (mounted) {
        final loc = AppLocalizations.of(context);
        ResultHandler.showErrorToast(context, loc.toast_invalidCredentials);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthHeader(title: loc.welcomeBack, subtitle: loc.signInSubtitle),
            const SizedBox(height: 32),
            AppTextField(
              controller: _emailController,
              label: loc.auth_email,
              hint: loc.enterEmail,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val == null || val.isEmpty) return loc.errors_requiredField;
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(val)) {
                  return loc.errors_invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _passwordController,
              label: loc.auth_password,
              hint: loc.enterPassword,
              prefixIcon: Icons.lock_outline,
              obscureText: !_isPasswordVisible,
              textInputAction: TextInputAction.done,
              validator: (val) {
                if (val == null || val.isEmpty) return loc.errors_requiredField;
                if (val.length < 6) return loc.errors_shortPassword;
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: loc.signInButton,
              onPressed: _signIn,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.surface,
              ),
              child: Text(
                loc.signInWithGoogle,
                style: context.buttonText.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildDivider(theme, loc),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.goNamed(AppRoutes.signUp),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                loc.createAccount,
                style: context.buttonText.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme, AppLocalizations loc) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            loc.or,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }
}
