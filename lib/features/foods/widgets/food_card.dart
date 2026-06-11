import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/food_item.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    required this.item,
    required this.onTapEdit,
    required this.onTapDelete,
    super.key,
  });

  final FoodItem item;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expirationDate = DateTime(
      item.expirationDate.year,
      item.expirationDate.month,
      item.expirationDate.day,
    );

    final daysLeft = expirationDate.difference(today).inDays;

    final bgColor = _getBackgroundColor(
      context: context,
      daysLeft: daysLeft,
    );

    final foodNameTextColor = theme.colorScheme.onSurface;

    final daysRemainingTextColor =
        daysLeft <= 0 ? Colors.white : foodNameTextColor;

    final hasExpirationGradient = bgColor != Colors.transparent;
    final baseColor = Theme.of(context).colorScheme.surfaceContainerLow;

    return Card(
      margin: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: hasExpirationGradient ? null : baseColor,
          gradient: hasExpirationGradient
              ? LinearGradient(
                  colors: [
                    baseColor,
                    bgColor,
                  ],
                  stops: const [
                    0.0,
                    1.0,
                  ],
                )
              : null,
        ),
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: item.openingDate == null ? 8 : 2,
          bottom: item.openingDate == null ? 8 : 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: onTapEdit,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _QuantityBadge(
                            quantity: item.quantity,
                            color: foodNameTextColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.foodName,
                              style: theme.textTheme.titleMedium?.copyWith(
                                  color: foodNameTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      if (item.openingDate != null)
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            'Opened',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                _buildExpirationText(daysLeft),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: daysRemainingTextColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              height: 32,
              child: FilledButton(
                onPressed: onTapDelete,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: theme.colorScheme.surfaceContainerLow,
                  foregroundColor: theme.colorScheme.secondary,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor({
    required BuildContext context,
    required int daysLeft,
  }) {
    final brightness = Theme.of(context).brightness;
    final isDarkTheme = brightness == Brightness.dark;

    if (daysLeft <= 0) {
      return isDarkTheme
          ? const Color(0xFFFFB4AB) // light red
          : const Color(0xFFBA1A1A); // dark red
    }

    if (daysLeft <= 7) {
      return getColorForDays(daysLeft);
    }

    return Colors.transparent;
  }

  String _buildExpirationText(int daysLeft) {
    if (daysLeft < -2) {
      return '${daysLeft.abs()} days ago';
    }

    if (daysLeft == -1) {
      return 'Yesterday';
    }

    if (daysLeft == 0) {
      return 'Today';
    }

    if (daysLeft == 1) {
      return 'Tomorrow';
    }

    if (daysLeft < 7) {
      return 'In $daysLeft days';
    }

    return '${item.expirationDate.day}/${item.expirationDate.month}/${item.expirationDate.year}';
  }
}

class _QuantityBadge extends StatelessWidget {
  const _QuantityBadge({
    required this.quantity,
    required this.color,
  });

  final int quantity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        quantity.toString(),
        style: TextStyle(
          fontSize: 12,
          height: 1,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Color getColorForDays(int days) {
  if (days > 7) {
    return Colors.transparent;
  }

  const maxDays = 7;
  const hueStart = 30.0; // orange
  const hueEnd = 60.0; // yellow

  final clampedDays = days.clamp(0, maxDays);
  final fraction = clampedDays / maxDays;

  final hue = lerpDouble(hueStart, hueEnd, fraction)!;
  final alpha = lerpDouble(1.0, 0.0, fraction)!;

  const saturation = 0.8;
  const lightness = 0.5;

  return HSLColor.fromAHSL(
    alpha,
    hue,
    saturation,
    lightness,
  ).toColor();
}
