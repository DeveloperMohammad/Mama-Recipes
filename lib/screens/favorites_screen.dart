import 'package:flutter/material.dart';
import 'package:mama_recipes/models/dummy_data.dart';
import 'package:mama_recipes/models/recipe.dart';
import 'package:mama_recipes/widgets/category_appbar_widget.dart';
import 'package:mama_recipes/widgets/recipe_list_tile_widget.dart';

import '../widgets/main_drawer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  static const routeName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final favorites = [];

  @override
  void initState() {
    for (Recipe recipe in recipes) {
      if (recipe.isFavorite == true) {
        favorites.add(recipe);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MainDrawer(),
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CategoryAppBarWidget(
                        title: 'غذا های مورد علاقه',
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final recipe = favorites[index];
                          return RecipeListTileWidget(recipe: recipe);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
