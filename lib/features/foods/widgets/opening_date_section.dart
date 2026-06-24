import 'package:flutter/material.dart';

import 'date_picker_field.dart';

class OpeningDateSection extends StatelessWidget {
  const OpeningDateSection({
    required this.enabled,
    required this.openingDate,
    required this.timeSpan,
    required this.timeSpanUnit,
    required this.onEnabledChanged,
    required this.onOpeningDateChanged,
    required this.onTimeSpanChanged,
    required this.onTimeSpanUnitChanged,
    super.key,
  });

  final bool enabled;
  final DateTime? openingDate;
  final int timeSpan;
  final String timeSpanUnit;

  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<DateTime> onOpeningDateChanged;
  final ValueChanged<int> onTimeSpanChanged;
  final ValueChanged<String> onTimeSpanUnitChanged;

  static const List<String> _timeSpanUnits = [
    'Days',
    'Months',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: colorScheme.surfaceContainerLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Checkbox(
                  value: enabled,
                  onChanged: (value) {
                    onEnabledChanged(value ?? false);
                  },
                ),
                Expanded(
                  child: Text(
                    'Opening date (optional)',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Opacity(
                opacity: enabled ? 1 : 0.5,
                child: DatePickerField(
                  label: 'Opening date',
                  selectedDate: openingDate,
                  enabled: enabled,
                  onDateSelected: onOpeningDateChanged,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Opacity(
              opacity: enabled ? 1 : 0.5,
              child: ColoredBox(
                color: colorScheme.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time span',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              enabled: enabled,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: TextEditingController(
                                text: timeSpan.toString(),
                              ),
                              onChanged: (value) {
                                onTimeSpanChanged(
                                  int.tryParse(value) ?? 0,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: timeSpanUnit,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              items: _timeSpanUnits.map((unit) {
                                return DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                );
                              }).toList(),
                              onChanged: enabled
                                  ? (value) {
                                      if (value != null) {
                                        onTimeSpanUnitChanged(value);
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
