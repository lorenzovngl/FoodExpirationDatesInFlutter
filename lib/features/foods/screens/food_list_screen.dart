import 'package:flutter/material.dart';
import 'package:food_expiration_dates/data/local/app_database.dart';

import '../models/food_item.dart';
import '../widgets/food_card.dart';
import 'insert_food_screen.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({
    required this.database,
    super.key,
  });

  final AppDatabase database;

  /*static final List<FoodItem> _items = [
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
  ];*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: StreamBuilder<List<Food>>(
        stream: database.watchFoods(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: Text(
                  'Food Expiration Dates',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              if (items.isEmpty)
                const SliverFillRemaining(
                  child: EmptyFoodList(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final foodItem = FoodItem(
                        id: item.id,
                        foodName: item.foodName,
                        expirationDate: item.expirationDate,
                        openingDate: item.openingDate,
                        timeSpanDays: item.timeSpanDays,
                        quantity: item.quantity,
                      );

                      return FoodCard(
                        item: foodItem,
                        onTapEdit: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InsertFoodScreen(
                                database: database,
                                itemToEdit: foodItem,
                              ),
                            ),
                          );
                        },
                        onTapDelete: () {
                          database.deleteFoodById(item.id);
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
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
                  builder: (context) => InsertFoodScreen(database: database),
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
