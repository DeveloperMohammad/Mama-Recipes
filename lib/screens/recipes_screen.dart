import 'package:flutter/material.dart';
import 'package:mama_recipes/constants/categories.dart';

import '../models/dummy_data.dart';
import '../models/recipe.dart';
import '../widgets/recipe_list_tile_widget.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  static const routeName = '/recipes';

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final List<Recipe> myRecipes = [];
  late Categories category;

  findCategory(String imageUrl) {
    switch (imageUrl) {
      case 'assets/images/food.jpg':
        category = Categories.food;
        break;
      case 'assets/images/pastry.jpg':
        category = Categories.pastry;
        break;
      case 'assets/images/cake.jpg':
        category = Categories.cake;
        break;
      case 'assets/images/vegetables.jpg':
        category = Categories.vegetables;
        break;
      case 'assets/images/drink.jpg':
        category = Categories.drink;
        break;
      case 'assets/images/fastfood.jpg':
        category = Categories.fastfood;
        break;
    }
  }

  addRecipes() {
    for (Recipe recipe in recipes) {
      if (recipe.categories.contains(category)) {
        myRecipes.add(recipe);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = ModalRoute.of(context)!.settings.arguments as String;
    findCategory(imageUrl);
    if (myRecipes.isEmpty) {
      addRecipes();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                    const Text(
                      'دستور پخت ها',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: myRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = myRecipes[index];
                      return RecipeListTileWidget(recipe: recipe);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
