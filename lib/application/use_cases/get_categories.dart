import '../../domain/repositories/menu_repository.dart';

class GetCategories {
  const GetCategories(this._repository);

  final MenuRepository _repository;

  /// Унікальні категорії у порядку появи в меню.
  List<String> call() =>
      _repository.getAll().map((item) => item.category).toSet().toList();
}
