import '../../domain/entities/menu_item.dart';

extension MenuItemImage on MenuItem {
  /// URL потрібної ширини: для Unsplash додається ?w=, інші адреси без змін.
  String? imageAt(int width) {
    final url = imageUrl;
    if (url == null) return null;
    return url.contains('images.unsplash.com') ? '$url?w=$width' : url;
  }
}
