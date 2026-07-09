import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:food_expiration_dates/data/local/app_database.dart';

import '../models/food_item.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/opening_date_section.dart';
import '../widgets/quantity_selector.dart';

class InsertFoodScreen extends StatefulWidget {
  const InsertFoodScreen({
    required this.database,
    this.itemToEdit,
    super.key,
  });

  final AppDatabase database;
  final FoodItem? itemToEdit;

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
  void initState() {
    super.initState();

    final item = widget.itemToEdit;

    if (item != null) {
      _foodNameController.text = item.foodName;
      _expirationDate = item.expirationDate;
      _openingDate = item.openingDate;
      _quantity = item.quantity;
      _timeSpan = item.timeSpanDays ?? 0;
      _hasOpeningDate = item.openingDate != null;
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    super.dispose();
  }

  void _onCancel() {
    Navigator.of(context).maybePop();
  }

  Future<void> _onInsert() async {
    final foodName = _foodNameController.text.trim();

    if (foodName.isEmpty) {
      _showMessage('Please enter a food name');
      return;
    }

    if (_expirationDate == null) {
      _showMessage('Please select a date');
      return;
    }

    final itemToEdit = widget.itemToEdit;

    if (itemToEdit == null) {
      await widget.database.insertFood(
        FoodsCompanion.insert(
          foodName: foodName,
          expirationDate: _expirationDate!,
          openingDate: drift.Value(_hasOpeningDate ? _openingDate : null),
          timeSpanDays: drift.Value(_hasOpeningDate ? _timeSpan : null),
          quantity: drift.Value(_quantity),
        ),
      );
    } else {
      await widget.database.updateFood(
        Food(
          id: itemToEdit.id!,
          foodName: foodName,
          expirationDate: _expirationDate!,
          openingDate: _hasOpeningDate ? _openingDate : null,
          timeSpanDays: _hasOpeningDate ? _timeSpan : null,
          quantity: _quantity,
        ),
      );
    }

    if (mounted) {
      Navigator.of(context).maybePop();
    }
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
    final isEditMode = widget.itemToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit food' : 'Insert food',
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
                      child: Text(isEditMode ? 'Update' : 'Insert'),
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
