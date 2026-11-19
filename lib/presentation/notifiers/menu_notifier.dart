import 'package:flutter/foundation.dart';

import '../../application/use_cases/filter_by_category.dart';
import '../../application/use_cases/get_categories.dart';
import '../../application/use_cases/get_menu_items.dart';
import '../../domain/entities/menu_item.dart';

/// Глобальний стан меню. Працює лише через use case-и, а не через сховище.
class MenuNotifier extends ChangeNotifier {
  MenuNotifier({
    required GetMenuItems getMenuItems,
    required GetCategories getCategories,
    required FilterByCategory filterByCategory,
  })  : _getMenuItems = getMenuItems,
        _getCategories = getCategories,
        _filterByCategory = filterByCategory;

  final GetMenuItems _getMenuItems;
  final GetCategories _getCategories;
  final FilterByCategory _filterByCategory;

  String? _selectedCategory; // null = показувати всі страви

  String? get selectedCategory => _selectedCategory;

  int get totalCount => _getMenuItems().length;

  List<String> get categories => _getCategories();

  List<MenuItem> get filteredItems => _filterByCategory(_selectedCategory);

  /// Повторний тап по вибраній категорії скидає фільтр.
  void selectCategory(String category) {
    _selectedCategory = (_selectedCategory == category) ? null : category;
    notifyListeners();
  }

  void clearFilter() {
    if (_selectedCategory == null) return;
    _selectedCategory = null;
    notifyListeners();
  }
}
