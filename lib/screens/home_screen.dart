import 'package:flutter/material.dart';
import 'package:mama_recipes/constants/styles.dart';
import 'package:mama_recipes/models/recipe.dart';
import 'package:mama_recipes/screens/recipes_screen.dart';
import 'package:mama_recipes/widgets/recipe_list_tile_widget.dart';

import '../models/category.dart';
import '../models/dummy_data.dart';
import '../widgets/category_appbar_widget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/recipe_category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _controller;

  List<Recipe> myRecipes = recipes;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: const MainDrawer(),
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CategoryAppBarWidget(
                      title: 'کتگوری های غذا',
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      autofocus: false,
                      controller: _controller,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColor,
                        filled: true,
                        hintText: 'اسم غذای مورد نظر را بنویسید',
                        border: searchFieldBorderStyle,
                        focusedBorder: searchFieldFocusedBorderStyle,
                        enabledBorder: searchFieldBorderStyle,
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.only(
                          right: 10,
                          left: 0,
                          top: 0,
                          bottom: 0,
                        ),
                      ),
                      onChanged: (value) {
                        searchRecipes(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    _controller.text.isEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index] as Category;
                                return RecipeCategoryWidget(
                                  categoryImageUrl: category.imageUrl,
                                  categoryTitle: category.category,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      RecipesScreen.routeName,
                                      arguments: category.imageUrl,
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: myRecipes.length,
                              itemBuilder: (context, index) {
                                return RecipeListTileWidget(
                                  recipe: myRecipes[index],
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void searchRecipes(String query) {
    List<Recipe> suggestions = recipes.where((recipe) {
      final title = recipe.name;
      return title.contains(query);
    }).toList();

    setState(() => myRecipes = suggestions);
  }
}
