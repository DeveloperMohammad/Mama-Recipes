import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mama_recipes/constants/difficulty.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({Key? key, this.preferences}) : super(key: key);

  static const routeName = '/recipe_detail';

  final SharedPreferences? preferences;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int currentStep = 0;
  String difficulty = '';

  @override
  Widget build(BuildContext context) {
    log(widget.preferences!.getStringList('favorite_recipes_ids').toString());

    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    if (recipe.difficulty == Difficulty.easy) {
      difficulty = 'آسان';
    } else if (recipe.difficulty == Difficulty.medium) {
      difficulty = 'متوسط';
    } else if (recipe.difficulty == Difficulty.difficult) {
      difficulty = 'سخت';
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                child: Image.asset(
                  'assets/images/${recipe.imageUrl}.webp',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (recipe.amount == null &&
                                recipe.duration == null)
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(Icons.signal_cellular_alt),
                                    Text(difficulty),
                                  ],
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            recipe.amount != null
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        const Icon(Icons.people),
                                        Text(recipe.amount!)
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            recipe.duration != null
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        const Icon(Icons.timer_sharp),
                                        Text(
                                          recipe.duration
                                              .toString()
                                              .substring(0, 7),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  recipe.isFavorite == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  final favs = widget.preferences!
                                          .getStringList(
                                              'favorite_recipes_ids') ??
                                      [];
                                  setState(() {
                                    recipe.isFavorite = !recipe.isFavorite;
                                    if (recipe.isFavorite) {
                                      favs.add(recipe.imageUrl);
                                      widget.preferences!.setStringList(
                                        'favorite_recipes_ids',
                                        favs,
                                      );
                                    } else {
                                      favs.remove(recipe.imageUrl);
                                      widget.preferences!.setStringList(
                                        'favorite_recipes_ids',
                                        favs,
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              recipe.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'مواد لازم',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).iconTheme.color),
                        //! Ingradients
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 7,
                            borderOnForeground: true,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: recipe.ingredients.map((ingradient) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: SelectableText(ingradient),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //! How to make
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'طرز تهیه',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).iconTheme.color),
                        //! Steps
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: recipe.steps.length,
                          itemBuilder: (context, index) {
                            final step = recipe.steps[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).iconTheme.color,
                                child: Text('${index + 1}'),
                              ),
                              title: Text(step),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        IconButton(
                          onPressed: () {
                            Share.share(recipe.toStringNew());
                          },
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
