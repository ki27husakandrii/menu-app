import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';

class GetMenuItems {
  const GetMenuItems(this._repository);

  final MenuRepository _repository;

  List<MenuItem> call() => List.unmodifiable(_repository.getAll());
}
