import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.enabled = true,
    super.key,
  });

  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final bool enabled;

  Future<void> _openDatePicker(BuildContext context) async {
    if (!enabled) {
      return;
    }

    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 20),
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      readOnly: true,
      enabled: enabled,
      controller: TextEditingController(
        text: selectedDate == null ? '' : _formatDate(selectedDate!),
      ),
      onTap: () => _openDatePicker(context),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: Icon(
          Icons.calendar_month_outlined,
          color: enabled
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withValues(alpha: 0.38),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
}
