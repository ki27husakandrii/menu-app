import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../data/menu_seed.dart';

/// Реалізація MenuRepository, що тримає дані в памʼяті.
class InMemoryMenuRepository implements MenuRepository {
  InMemoryMenuRepository([List<MenuItem>? items])
      : _items = List.of(items ?? kMenuSeed);

  final List<MenuItem> _items;

  @override
  List<MenuItem> getAll() => List.unmodifiable(_items);
}
