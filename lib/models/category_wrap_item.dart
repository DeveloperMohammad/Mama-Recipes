
import 'package:mama_recipes/constants/categories.dart';

class CategoryWrapItem {
  final String category;
  final Categories enumCategory;
  bool isSelected;

  CategoryWrapItem({
    required this.category,
    required this.enumCategory,
    this.isSelected = false,
  });

  @override
  String toString() {
    return 'category: $category';
  }
}
