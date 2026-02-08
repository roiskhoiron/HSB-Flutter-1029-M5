import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

enum GradientType { bottomUp, topDown }

class AppBackgroundGradient extends StatelessWidget {
  final GradientType type;
  final double? height;

  const AppBackgroundGradient({
    super.key,
    this.type = GradientType.topDown,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colors = type == GradientType.topDown
        ? [
            context.colorScheme.primary.withValues(alpha: 0.1),
            context.colorScheme.surface,
          ]
        : [
            context.colorScheme.primary.withValues(alpha: 0.8),
            context.colorScheme.primary.withValues(alpha: 0.4),
            Colors.transparent,
          ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: type == GradientType.topDown
              ? Alignment.topCenter
              : Alignment.bottomCenter,
          end: type == GradientType.topDown
              ? Alignment.bottomCenter
              : Alignment.topCenter,
          colors: colors,
        ),
      ),
    );
  }
}
