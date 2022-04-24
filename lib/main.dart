//! Dart imports

//? Flutter Imports
import 'package:mama_recipes/screens/filter_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//~ External Classes
import 'screens/bottom_navigation_bar_screen.dart';
import 'screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'screens/favorites_screen.dart';
import 'provider/theme_provider.dart';
import 'screens/about_us_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/home_screen.dart';
import 'models/dummy_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final ids = prefs.getStringList('favorite_recipes_ids') ?? [];
  // log('main: ${ids.toString()}');

  for (var recipe in recipes) {
    if (ids.contains(recipe.imageUrl)) {
      recipe.isFavorite = true;
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            isDarkMode: prefs.getBool('isDarkMode') ?? false,
          ),
        ),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const BottomNavigationBarScreen(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            RecipesScreen.routeName: (context) => const RecipesScreen(),
            RecipeDetailsScreen.routeName: (context) => RecipeDetailsScreen(
                  preferences: prefs,
                ),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            FavoritesScreen.routeName: (context) => const FavoritesScreen(),
            AboutUsScreen.routeName: (context) => const AboutUsScreen(),
            BottomNavigationBarScreen.routeName: (context) =>
                const BottomNavigationBarScreen(),
            FilterScreen.routeName: (context) => const FilterScreen(),
          },
        );
      },
    ),
  );
}
