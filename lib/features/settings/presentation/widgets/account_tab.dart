import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/app_footer.dart';
import 'package:travel_planner/shared/widgets/settings_tile.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SectionCard(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.logout_outlined,
                    title: context.l10n.signOut,
                    subtitle: context.l10n.signOutConfirmation,
                    iconColor: Colors.red,
                    onTap: () => _showSignOutDialog(context),
                    showDivider: true,
                  ),
                  SettingsTile(
                    icon: Icons.delete_forever_outlined,
                    title: context.l10n.deleteAccount,
                    subtitle: context.l10n.deleteAccountWarning,
                    iconColor: Colors.red,
                    onTap: () => _showDeleteAccountDialog(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        const AppFooter(),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.signOut),
        content: Text(context.l10n.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: context.colorScheme.onSurface),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  context.goNamed(AppRoutes.auth);
                }
              } catch (e) {
                if (context.mounted) {
                  ResultHandler.showErrorToast(
                    context,
                    context.l10n.failedToSignOut,
                  );
                }
              }
            },
            child: Text(
              context.l10n.signOut,
              style: const TextStyle(color: Color(0xFFE91E63)),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.l10n.deleteAccount,
          style: const TextStyle(color: Colors.red),
        ),
        content: Text(context.l10n.deleteAccountConfirmation),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: context.colorScheme.onSurface),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  context.goNamed(AppRoutes.auth);
                }
              } catch (e) {
                if (context.mounted) {
                  ResultHandler.showErrorToast(
                    context,
                    context.l10n.failedToDeleteAccount,
                  );
                }
              }
            },
            child: Text(
              context.l10n.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
