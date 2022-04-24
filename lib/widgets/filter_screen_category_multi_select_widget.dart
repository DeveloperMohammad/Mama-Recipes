import 'package:flutter/material.dart';

import '../constants/categories.dart';
import '../models/category_wrap_item.dart';

class FilterScreenCategoryMultiSelectWidget extends StatefulWidget {
  const FilterScreenCategoryMultiSelectWidget({
    Key? key,
    required this.selectedCategories,
  }) : super(key: key);

  final List<Categories> selectedCategories;

  @override
  State<FilterScreenCategoryMultiSelectWidget> createState() =>
      _FilterScreenCategoryMultiSelectWidgetState();
}

class _FilterScreenCategoryMultiSelectWidgetState
    extends State<FilterScreenCategoryMultiSelectWidget> {

List<CategoryWrapItem> filterCategories = [
    CategoryWrapItem(category: 'کیک', enumCategory: Categories.cake),
    CategoryWrapItem(category: 'نوشیدنی', enumCategory: Categories.drink),
    CategoryWrapItem(category: 'فست فود', enumCategory: Categories.fastfood),
    CategoryWrapItem(category: 'غذا', enumCategory: Categories.food),
    CategoryWrapItem(category: 'شیرینی', enumCategory: Categories.pastry),
    CategoryWrapItem(category: 'سبزی', enumCategory: Categories.vegetables),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: filterCategories.map((item) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (item.isSelected == false) {
                item.isSelected = true;
                widget.selectedCategories.add(item.enumCategory);
              } else {
                item.isSelected = false;
                widget.selectedCategories.remove(item.enumCategory);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: item.isSelected ? Theme.of(context).highlightColor : Theme.of(context).backgroundColor,
            ),
            child: Text(
              item.category,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}