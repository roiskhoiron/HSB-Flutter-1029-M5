import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/localization/language_config.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});
  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  String _getCurrentLanguageCode(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final currentCode = _getCurrentLanguageCode(context);
    return AppDropdown<String>(
      value: currentCode,
      borderRadius: 12,
      items: AppLanguageConfig.all.map((language) {
        return DropdownMenuItem<String>(
          value: language.code,
          child: Row(
            children: [
              Text(language.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(language.nativeName, style: context.labelLarge),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          context.read<LanguageProvider>().changeLanguage(newValue);
        }
      },
    );
  }
}
