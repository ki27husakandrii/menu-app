import 'package:flutter/material.dart';

import '../../domain/entities/ingredient.dart';

extension IngredientKindIcon on IngredientKind {
  IconData get icon => switch (this) {
        IngredientKind.meat => Icons.lunch_dining,
        IngredientKind.bread => Icons.bakery_dining,
        IngredientKind.dairy => Icons.cookie_outlined,
        IngredientKind.vegetable => Icons.eco,
        IngredientKind.sauce => Icons.blender,
        IngredientKind.drink => Icons.local_drink,
        IngredientKind.dessert => Icons.icecream,
      };
}
