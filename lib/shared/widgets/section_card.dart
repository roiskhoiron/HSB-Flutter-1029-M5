import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_typography.dart';

class SectionCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? description;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.description,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.boxShadow,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final card = _buildSectionCard(context);
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }
    return card;
  }

  Widget _buildSectionCard(BuildContext context) {
    final theme = Theme.of(context);

    final card = Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 24),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: context.titleMedium.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (description != null) ...[
            Text(
              description!,
              style: context.bodySmall.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );

    return card;
  }
}
