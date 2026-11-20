import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/menu_item.dart';
import '../notifiers/menu_notifier.dart';
import '../utils/menu_item_image.dart';
import 'dish_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Меню закладу'),
        centerTitle: true,
        actions: [
          // Selector: перебудовується лише при зміні КІЛЬКОСТІ страв
          Selector<MenuNotifier, int>(
            selector: (_, notifier) => notifier.filteredItems.length,
            builder: (context, count, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Badge(
                  label: Text('$count'),
                  child: const Icon(Icons.restaurant_menu),
                ),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          CategoryChips(),
          FilterSummary(),
          Expanded(child: MenuList()),
        ],
      ),
    );
  }
}

/// Місце 1: чіпи категорій (context.watch).
class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MenuNotifier>();
    final categories = notifier.categories;

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            key: ValueKey(category),
            label: Text(category),
            selected: notifier.selectedCategory == category,
            onSelected: (_) => context.read<MenuNotifier>().selectCategory(category),
          );
        },
      ),
    );
  }
}

/// Рядок-підсумок фільтра (Consumer).
class FilterSummary extends StatelessWidget {
  const FilterSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuNotifier>(
      builder: (context, notifier, _) {
        final selected = notifier.selectedCategory;
        final count = notifier.filteredItems.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selected == null
                      ? 'Усі страви: $count'
                      : '$selected: $count з ${notifier.totalCount}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              if (selected != null)
                TextButton(
                  onPressed: () => context.read<MenuNotifier>().clearFilter(),
                  child: const Text('Скинути'),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Місце 2: список страв (context.watch).
class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<MenuNotifier>().filteredItems;

    if (items.isEmpty) {
      return const Center(child: Text('У цій категорії поки немає страв'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return MenuCard(key: ValueKey(item.id), item: item);
      },
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final placeholder = Container(
      color: colorScheme.primaryContainer,
      child: Icon(Icons.restaurant, color: colorScheme.onPrimaryContainer),
    );

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: SizedBox(
          width: 64,
          height: 64,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.imageUrl == null
                ? placeholder
                : Image.network(
                    item.imageAt(200)!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => placeholder,
                  ),
          ),
        ),
        title: Text(
          item.name,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${item.category} · ${item.minutes} хв · ★ ${item.rating}'),
        trailing: Text(
          '₴ ${item.price.toStringAsFixed(0)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => DishScreen(item: item)),
          );
        },
      ),
    );
  }
}
