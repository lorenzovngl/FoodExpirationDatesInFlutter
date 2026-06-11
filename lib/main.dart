import 'package:flutter/material.dart';

import 'features/foods/screens/food_list_screen.dart';

void main() {
  runApp(const FoodExpirationDatesApp());
}

class FoodExpirationDatesApp extends StatelessWidget {
  const FoodExpirationDatesApp({super.key});

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
      home: const FoodListScreen(),
    );
  }
}
