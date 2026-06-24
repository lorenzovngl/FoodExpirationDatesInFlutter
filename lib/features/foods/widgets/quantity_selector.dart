import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    required this.quantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    super.key,
  });

  final int quantity;
  final int minQuantity;
  final ValueChanged<int> onQuantityChanged;

  void _decreaseQuantity() {
    if (quantity > minQuantity) {
      onQuantityChanged(quantity - 1);
    }
  }

  void _increaseQuantity() {
    onQuantityChanged(quantity + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(
          icon: Icons.remove,
          enabled: quantity > minQuantity,
          onPressed: _decreaseQuantity,
        ),
        SizedBox(
          width: 40,
          child: Text(
            quantity.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        _QuantityButton(
          icon: Icons.add,
          enabled: true,
          onPressed: _increaseQuantity,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton.filledTonal(
        onPressed: enabled ? onPressed : null,
        icon: Icon(icon),
        iconSize: 18,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          disabledBackgroundColor:
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          disabledForegroundColor:
              colorScheme.onSurface.withValues(alpha: 0.38),
        ),
      ),
    );
  }
}
