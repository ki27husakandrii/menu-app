import '../entities/menu_item.dart';

/// Контракт доступу до даних меню. Domain залежить лише від цього інтерфейсу.
abstract class MenuRepository {
  List<MenuItem> getAll();
}
