import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/providers/theme_provider.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    final currentMode = themeProvider.themeMode;
    final currentValue = _getThemeValue(currentMode);

    return AppDropdown<String>(
      value: currentValue,
      borderRadius: 12,
      onChanged: (String? newValue) {
        if (newValue != null) {
          switch (newValue) {
            case 'light':
              themeProvider.setThemeMode(ThemeMode.light);
              break;
            case 'dark':
              themeProvider.setThemeMode(ThemeMode.dark);
              break;
            case 'system':
              themeProvider.setThemeMode(ThemeMode.system);
              break;
          }
        }
      },
      items: [
        DropdownMenuItem<String>(
          value: 'light',
          child: Row(
            children: [
              const Icon(
                Icons.light_mode_outlined,
                size: 20,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).themeLight,
                style: context.labelLarge,
              ),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'dark',
          child: Row(
            children: [
              const Icon(
                Icons.dark_mode_outlined,
                size: 20,
                color: Color(0xFFE91E63),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).themeDark,
                style: context.labelLarge,
              ),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'system',
          child: Row(
            children: [
              const Icon(
                Icons.brightness_auto_outlined,
                size: 20,
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).themeSystem,
                style: context.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getThemeValue(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
