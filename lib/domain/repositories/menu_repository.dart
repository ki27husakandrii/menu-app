import '../entities/menu_item.dart';

abstract class MenuRepository {
  List<MenuItem> getAll();
}
