import 'package:flutter/material.dart';

import '../widgets/recipe_list_tile_widget.dart';
import '../models/recipe.dart';

class FilterResultWidget extends StatelessWidget {
  const FilterResultWidget({
    Key? key,
    required this.selectedRecipes,
    required this.onPressed,
  }) : super(key: key);

  final List<Recipe> selectedRecipes;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: selectedRecipes.length,
            itemBuilder: (context, index) {
              final item = selectedRecipes[index];
              return RecipeListTileWidget(
                recipe: item,
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('بازگشت به صفحه قبل'),
          style: const ButtonStyle(
            // backgroundColor: MaterialStateProperty.all(
            //   Theme.of(context).backgroundColor,
            // )
          ),
        ),
      ],
    );
  }
}