import 'package:mama_recipes/constants/difficulty.dart';

import '../constants/categories.dart';

class Recipe {
  String name;
  Duration? duration;
  String? amount;
  List<String> ingredients;
  List<String> steps;
  List<Categories> categories;
  String imageUrl;
  bool isFavorite;
  Difficulty difficulty;
  bool isHealhty;

  Recipe({
    required this.name,
    this.duration,
    this.amount,
    required this.ingredients,
    required this.steps,
    required this.categories,
    required this.imageUrl,
    this.isFavorite = false,
    required this.difficulty,
    this.isHealhty = true,
  });

  String toStringNew() {
    final recipeIngredients = ingredients.map((ingredient) => ingredient + '\n');
    final recipeSteps = steps;
    final recipeCategories = [];

    for(int i = 0; i < steps.length; i++) {
      recipeSteps[i] = '$i--' + recipeSteps[i] + '\n';
    }

    if(categories.contains(Categories.food)) {
      recipeCategories.add('غذا');
    } else if(categories.contains(Categories.drink)) {
      recipeCategories.add('نوشیدنی');
    } else if(categories.contains(Categories.fastfood)) {
      recipeCategories.add('فست فود');
    } else if(categories.contains(Categories.pastry)) {
      recipeCategories.add('شیرینی');
    } else if(categories.contains(Categories.vegetables)) {
      recipeCategories.add('سبزیجات');
    } else if(categories.contains(Categories.cake)) {
      recipeCategories.add('کیک');
    } 

    return '$name\n\n$recipeIngredients\n\n$recipeSteps\n\n$recipeCategories\n';
  }
}
