import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';

/// Use case: відбір страв за категорією. Працює лише через інтерфейс MenuRepository.
class FilterByCategory {
  const FilterByCategory(this._repository);

  final MenuRepository _repository;

  /// category == null означає «усі страви».
  List<MenuItem> call(String? category) {
    final items = _repository.getAll();
    if (category == null) {
      return List.unmodifiable(items);
    }
    return List.unmodifiable(items.where((item) => item.category == category));
  }
}
