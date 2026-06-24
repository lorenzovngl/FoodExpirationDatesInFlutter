import 'package:flutter/material.dart';

import '../widgets/date_picker_field.dart';
import '../widgets/opening_date_section.dart';
import '../widgets/quantity_selector.dart';

class InsertFoodScreen extends StatefulWidget {
  const InsertFoodScreen({super.key});

  @override
  State<InsertFoodScreen> createState() => _InsertFoodScreenState();
}

class _InsertFoodScreenState extends State<InsertFoodScreen> {
  final _foodNameController = TextEditingController();

  DateTime? _expirationDate;
  DateTime? _openingDate;

  int _quantity = 1;
  int _timeSpan = 0;
  String _timeSpanUnit = 'Days';

  bool _hasOpeningDate = false;

  @override
  void dispose() {
    _foodNameController.dispose();
    super.dispose();
  }

  void _onCancel() {
    Navigator.of(context).maybePop();
  }

  void _onInsert() {
    final foodName = _foodNameController.text.trim();

    if (foodName.isEmpty) {
      _showMessage('Please enter a food name');
      return;
    }

    if (_expirationDate == null) {
      _showMessage('Please select a date');
      return;
    }

    // TODO: Save food item when persistence is implemented.
    // For now this screen only manages local UI state.

    Navigator.of(context).maybePop();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insert food',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _foodNameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Food name',
                  border: OutlineInputBorder(),
                ),
              ),
              DatePickerField(
                label: 'Expiration date',
                selectedDate: _expirationDate,
                onDateSelected: (date) {
                  setState(() {
                    _expirationDate = date;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity',
                    style: theme.textTheme.bodyLarge,
                  ),
                  QuantitySelector(
                    quantity: _quantity,
                    onQuantityChanged: (quantity) {
                      setState(() {
                        _quantity = quantity;
                      });
                    },
                  ),
                ],
              ),
              OpeningDateSection(
                enabled: _hasOpeningDate,
                openingDate: _openingDate,
                timeSpan: _timeSpan,
                timeSpanUnit: _timeSpanUnit,
                onEnabledChanged: (enabled) {
                  setState(() {
                    _hasOpeningDate = enabled;

                    if (!enabled) {
                      _openingDate = null;
                      _timeSpan = 0;
                      _timeSpanUnit = 'Days';
                    }
                  });
                },
                onOpeningDateChanged: (date) {
                  setState(() {
                    _openingDate = date;
                  });
                },
                onTimeSpanChanged: (timeSpan) {
                  setState(() {
                    _timeSpan = timeSpan;
                  });
                },
                onTimeSpanUnitChanged: (unit) {
                  setState(() {
                    _timeSpanUnit = unit;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.tertiary,
                        side: BorderSide(
                          color: colorScheme.tertiary,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: _onInsert,
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.tertiary,
                        foregroundColor: colorScheme.onTertiary,
                      ),
                      child: const Text('Insert'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
