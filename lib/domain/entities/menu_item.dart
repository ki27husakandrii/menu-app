import 'ingredient.dart';

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.minutes,
    required this.rating,
    required this.reviews,
    required this.ingredients,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final int minutes;
  final double rating;
  final int reviews;
  final List<Ingredient> ingredients;
  final String? imageUrl;

  /// Бізнес-правило: вага страви дорівнює сумі ваги інгредієнтів.
  int get totalGrams => ingredients.fold<int>(0, (sum, i) => sum + i.grams);
}
