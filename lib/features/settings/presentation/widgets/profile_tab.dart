import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/user_avatar.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        spacing: 16,
        children: [
          SectionCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              spacing: 24,
              children: [
                const UserAvatar(size: 100, showStatus: true, showName: false),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      user?.name ?? context.l10n.profile,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        context.l10n.manageYourProfile.toUpperCase(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SectionCard(
            title: context.l10n.personalInformation,
            child: Column(
              spacing: 20,
              children: [
                AppTextField(
                  controller: TextEditingController(text: user?.name ?? ''),
                  label: context.l10n.name,
                  hint: context.l10n.enterName,
                  prefixIcon: Icons.person_outline,
                  enabled: false,
                ),
                AppTextField(
                  controller: TextEditingController(text: user?.email ?? ''),
                  label: context.l10n.email,
                  hint: context.l10n.enterEmail,
                  prefixIcon: Icons.email_outlined,
                  enabled: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
