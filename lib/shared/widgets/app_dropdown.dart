import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final Widget? prefixIcon;
  final IconData? icon;
  final double borderRadius;
  final bool enabled;
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.prefixIcon,
    this.icon,
    this.borderRadius = 16,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const primaryRose = Color(0xFFE91E63);
    const lightRose = Color(0xFFFCE4EC);
    const softPink = Color(0xFFF8BBD0);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? 8 : 16,
        vertical: icon != null ? 0 : 4,
      ),
      decoration: BoxDecoration(
        color: icon != null
            ? Colors.transparent
            : (theme.brightness == Brightness.dark
                  ? const Color(0xFF2A2A3E)
                  : softPink.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(borderRadius),
        border: icon != null
            ? null
            : Border.all(
                color: theme.brightness == Brightness.dark
                    ? primaryRose.withValues(alpha: 0.3)
                    : lightRose.withValues(alpha: 0.5),
              ),
      ),
      child: DropdownButton<T>(
        value: value,
        underline: const SizedBox(),
        icon: Icon(
          icon ?? Icons.keyboard_arrow_down,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          size: icon != null ? 20 : 24,
        ),
        hint: icon != null ? const SizedBox.shrink() : null,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: theme.brightness == Brightness.dark
            ? const Color(0xFF2A2A3E)
            : Colors.white,
        menuMaxHeight: 200,
        borderRadius: BorderRadius.circular(12),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item.value,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: item.child,
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
