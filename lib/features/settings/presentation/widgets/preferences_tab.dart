import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/core/localization/language_config.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';
import 'package:travel_planner/shared/widgets/settings_tile.dart';

class PreferencesTab extends StatelessWidget {
  const PreferencesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SectionCard(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            SettingsTile(
              icon: Icons.language_outlined,
              title: context.l10n.language,
              subtitle:
                  languageProvider.currentLanguage?.nativeName ?? 'English',
              trailing: AppDropdown<AppLanguage>(
                value:
                    languageProvider.currentLanguage ??
                    AppLanguageConfig.all.first,
                items: AppLanguageConfig.all.map((AppLanguage lang) {
                  return DropdownMenuItem<AppLanguage>(
                    value: lang,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(lang.emoji),
                        const SizedBox(width: 8),
                        Text(lang.nativeName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (AppLanguage? newValue) async {
                  if (newValue != null) {
                    await languageProvider.changeLanguage(newValue.code);
                  }
                },
              ),
              showDivider: true,
            ),
            SettingsTile(
              icon: Icons.palette_outlined,
              title: context.l10n.theme,
              subtitle: context.l10n.chooseTheme,
              trailing: const ThemeSwitch(),
              showDivider: true,
            ),
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: context.l10n.notifications,
              subtitle: context.l10n.manageNotifications,
              showDivider: true,
            ),
            SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: context.l10n.privacy,
              subtitle: context.l10n.managePrivacy,
            ),
          ],
        ),
      ),
    );
  }
}
