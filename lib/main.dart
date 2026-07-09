import 'package:flutter/material.dart';
import 'package:food_expiration_dates/data/local/app_database.dart';

import 'features/foods/screens/food_list_screen.dart';

void main() {
  final database = AppDatabase();

  runApp(FoodExpirationDatesApp(
    database: database,
  ));
}

class FoodExpirationDatesApp extends StatelessWidget {
  const FoodExpirationDatesApp({
    required this.database,
    super.key,
  });

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Expiration Dates",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA7D10),
        ),
        useMaterial3: true,
      ),
      home: FoodListScreen(database: database),
    );
  }
}
