/// Тип інгредієнта. Яку саме іконку показати, вирішує Presentation-шар,
/// тому Domain не залежить від Flutter.
enum IngredientKind { meat, bread, dairy, vegetable, sauce, drink, dessert }

class Ingredient {
  const Ingredient(this.name, this.grams, this.kind);

  final String name;
  final int grams;
  final IngredientKind kind;
}
