import 'package:flutter/material.dart';

import '../widgets/filter_screen_category_multi_select_widget.dart';
import '../widgets/filter_result_widget.dart';
import '../constants/difficulty.dart';
import '../constants/categories.dart';
import '../models/difficulty.dart';
import '../models/dummy_data.dart';
import '../models/duration.dart';
import '../models/recipe.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  static const routeName = '/filter';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Difficulty difficultyValue = Difficulty.none;
  Duration maxDuration = const Duration();
  Duration minDuration = const Duration();

  DurationFilter durationFilter = const DurationFilter(
    title: 'نامشخص',
    maxDuration: Duration(),
    minDuration: Duration(),
  );

  bool isHealthy = false;

  final List<Categories> selectedCategories = [];
  final List<Recipe> selectedRecipes = [];

  final List<DifficultyFilter> difficulty = [
    DifficultyFilter(title: 'ساده', difficulty: Difficulty.easy),
    DifficultyFilter(title: 'متوسط', difficulty: Difficulty.medium),
    DifficultyFilter(title: 'سخت', difficulty: Difficulty.difficult),
    DifficultyFilter(title: 'نامشخص', difficulty: Difficulty.none),
  ];

  final List<DurationFilter> durations = [
    const DurationFilter(
      title: '5 تا 25 دقیقه',
      minDuration: Duration(minutes: 5),
      maxDuration: Duration(minutes: 25),
    ),
    const DurationFilter(
      title: '25 دقیقه تا 1 ساعت',
      minDuration: Duration(minutes: 25),
      maxDuration: Duration(hours: 1),
    ),
    const DurationFilter(
      title: 'بیشتر از 1 ساعت',
      minDuration: Duration(hours: 1),
      maxDuration: Duration(hours: 5),
    ),
    const DurationFilter(
      title: 'نامشخص',
      minDuration: Duration(minutes: 0),
      maxDuration: Duration(minutes: 0),
    ),
  ];

  bool showResults = false;

  void filterSearch() {
    recipes.map(
      (recipe) {
        for (var category in selectedCategories) {
          if (recipe.categories.contains(category)) {
            if (difficultyValue == Difficulty.none ||
                recipe.difficulty == difficultyValue) {
              if (recipe.duration != null) {
                if (durationFilter.title == 'نامشخص' ||
                    (recipe.duration!.inMinutes > minDuration.inMinutes &&
                        recipe.duration!.inMinutes < maxDuration.inMinutes)) {
                  if (isHealthy == false || recipe.isHealhty == isHealthy) {
                    selectedRecipes.add(recipe);
                  }
                }
              } else if (recipe.duration == null) {
                if (isHealthy == false || recipe.isHealhty == isHealthy) {
                  selectedRecipes.add(recipe);
                }
              }
            }
          }
        }
      },
    ).toList();

    setState(() => showResults = true);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          centerTitle: true,
          title: Text(
            'جستجو پیشرفته',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: SafeArea(
          child: showResults == false
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'نوعیت غذا',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilterScreenCategoryMultiSelectWidget(
                          selectedCategories: selectedCategories,
                        ),
                        const SizedBox(height: 20),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Theme.of(context).backgroundColor,
                          ),
                          child: DropdownButtonFormField<Difficulty>(
                            value: difficultyValue,
                            decoration: const InputDecoration(
                              hintText: 'سختی غذا را انتخاب کنید',
                            ),
                            items: difficulty.map((item) {
                              return DropdownMenuItem<Difficulty>(
                                value: item.difficulty,
                                child: Text(item.title),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                difficultyValue = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Theme.of(context).backgroundColor,
                          ),
                          child: DropdownButtonFormField<DurationFilter>( 
                            value: durationFilter,
                            alignment: AlignmentDirectional.bottomStart,
                            decoration: const InputDecoration(
                              hintText: 'مدت پخت غذا را انتخاب کنید',
                            ),
                            items: durations.map((item) {
                              return DropdownMenuItem<DurationFilter>(
                                value: item,
                                child: Text(item.title),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                durationFilter = value!;
                                maxDuration = value.maxDuration;
                                minDuration = value.minDuration;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('مضر'),
                            Switch(
                              value: isHealthy,
                              onChanged: (value) {
                                setState(() {
                                  isHealthy = value;
                                });
                              },
                            ),
                            const Text('مفید'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: const ButtonStyle(
                              ),
                          onPressed: filterSearch,
                          child: const Text('جستجو'),
                        ),
                      ],
                    ),
                  ),
                )
              : FilterResultWidget(
                  selectedRecipes: selectedRecipes,
                  onPressed: () {
                    setState(() {
                      showResults = false;
                      selectedRecipes.clear();
                    });
                  },
                ),
        ),
      ),
    );
  }
}
