import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../widgets/food_card.dart';
import 'insert_food_screen.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  static final List<FoodItem> _items = [
    FoodItem(
        foodName: 'Eggs',
        expirationDate: DateTime.now().add(const Duration(days: -1)),
        quantity: 3),
    FoodItem(
        foodName: 'Cheese',
        expirationDate: DateTime.now().add(const Duration(days: 0))),
    FoodItem(
        foodName: 'Milk',
        expirationDate: DateTime.now().add(const Duration(days: 1))),
    FoodItem(
        foodName: 'Ham',
        expirationDate: DateTime.now().add(const Duration(days: 3)),
        quantity: 3),
    FoodItem(
        foodName: 'Butter',
        expirationDate: DateTime.now().add(const Duration(days: 7))),
    FoodItem(
        foodName: 'Mushrooms',
        expirationDate: DateTime.now().add(const Duration(days: 10)),
        quantity: 7),
    FoodItem(
        foodName: 'Tomatoes',
        expirationDate: DateTime.now().add(const Duration(days: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              'Food Expiration Dates',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ),
          if (_items.isEmpty)
            const SliverFillRemaining(
              child: EmptyFoodList(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList.separated(
                itemCount: _items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 0),
                itemBuilder: (context, index) {
                  return FoodCard(
                    item: _items[index],
                    onTapEdit: () {},
                    onTapDelete: () {},
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;

          return FloatingActionButton(
            backgroundColor: colorScheme.tertiaryContainer,
            foregroundColor: colorScheme.onTertiaryContainer,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const InsertFoodScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class EmptyFoodList extends StatelessWidget {
  const EmptyFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surface,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              'No items found',
              style: theme.textTheme.displaySmall?.copyWith(
                fontSize: 24,
                color: theme.colorScheme.secondary.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Please insert one',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
