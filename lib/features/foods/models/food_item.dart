class FoodItem {
  const FoodItem({
    required this.foodName,
    required this.expirationDate,
    this.openingDate,
    this.timeSpanDays,
    this.quantity = 1,
  });

  final String foodName;
  final DateTime expirationDate;
  final DateTime? openingDate;
  final int? timeSpanDays;
  final int quantity;
}
