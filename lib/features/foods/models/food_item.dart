class FoodItem {
  const FoodItem({
    this.id,
    required this.foodName,
    required this.expirationDate,
    this.openingDate,
    this.timeSpanDays,
    this.quantity = 1,
  });

  final int? id;
  final String foodName;
  final DateTime expirationDate;
  final DateTime? openingDate;
  final int? timeSpanDays;
  final int quantity;
}
