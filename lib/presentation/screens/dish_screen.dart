import 'package:flutter/material.dart';

import '../../domain/entities/menu_item.dart';
import '../utils/ingredient_icon.dart';
import '../utils/menu_item_image.dart';

/// Екран страви з Лаб. №4. Локальний стан екрана (порції, замовлення,
/// контролер тексту) залишається у State, бо потрібен лише цьому екрану.
class DishScreen extends StatefulWidget {
  const DishScreen({super.key, required this.item});

  final MenuItem item;

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  static const int _maxServings = 10;

  int _servings = 1;
  bool _ordered = false;
  String _note = '';

  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  // ---------- Обробники подій ----------
  void _onIncrement() {
    if (_servings < _maxServings) {
      setState(() => _servings++);
    }
  }

  void _onDecrement() {
    if (_servings > 1) {
      setState(() => _servings--);
    }
  }

  void _onNoteChanged(String value) {
    setState(() => _note = value);
  }

  void _onOrderPressed() {
    setState(() => _ordered = !_ordered);

    final message = _ordered
        ? 'Замовлено: ${widget.item.name}, $_servings порц.${_note.trim().isEmpty ? '' : '\nПобажання: ${_note.trim()}'}'
        : 'Замовлення скасовано';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // ---------- Обчислення ----------
  int get _totalGrams => widget.item.totalGrams * _servings;

  String get _totalPrice => (widget.item.price * _servings).toStringAsFixed(2);

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Деталі страви'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Додати в обране',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Поділитися',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 700;

                  if (isWide) {
                    // ПЛАНШЕТ: фото ліворуч на всю висоту, інформація праворуч
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildPhoto(theme, colorScheme),
                        ),
                        Expanded(
                          flex: 6,
                          child: SingleChildScrollView(
                            child: _buildDetails(theme, colorScheme),
                          ),
                        ),
                      ],
                    );
                  }

                  // ТЕЛЕФОН: фото 250h зверху, нижче Column; весь вміст прокручується
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPhoto(theme, colorScheme, height: 250),
                        _buildDetails(theme, colorScheme),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildOrderBar(theme, colorScheme),
          ],
        ),
      ),
    );
  }

  // Stack: фото (Container) + Positioned бейдж категорії
  Widget _buildPhoto(ThemeData theme, ColorScheme colorScheme, {double? height}) {
    final url = widget.item.imageUrl;

    return Stack(
      fit: height == null ? StackFit.expand : StackFit.loose,
      children: [
        Container(
          width: double.infinity,
          height: height,
          color: colorScheme.surfaceContainerHighest,
          child: url == null
              ? _photoPlaceholder(colorScheme)
              : Image.network(
                  widget.item.imageAt(1200)!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.2),
                  errorBuilder: (context, error, stackTrace) =>
                      _photoPlaceholder(colorScheme),
                ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ],
            ),
            child: Text(
              widget.item.category,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _photoPlaceholder(ColorScheme colorScheme) {
    return Center(
      child: Icon(Icons.restaurant, size: 72, color: colorScheme.outline),
    );
  }

  // Column: назва, Row зі статистикою, вибір порцій, склад, поле побажань
  Widget _buildDetails(ThemeData theme, ColorScheme colorScheme) {
    final item = widget.item;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              item.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _statCard(theme, colorScheme, Icons.scale_outlined, '$_totalGrams г'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(theme, colorScheme, Icons.timer_outlined, '${item.minutes} хв'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(theme, colorScheme, Icons.star,
                    '${item.rating} (${item.reviews})',
                    iconColor: Colors.amber),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildServingsSelector(theme),
          const SizedBox(height: 8),

          Text(
            'Склад та інгредієнти',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item.ingredients.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final ingredient = item.ingredients[index];
              final int grams = ingredient.grams * _servings;
              return ListTile(
                key: ValueKey(ingredient.name),
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(ingredient.kind.icon, color: colorScheme.onPrimaryContainer),
                ),
                title: Text(ingredient.name, style: theme.textTheme.bodyLarge),
                trailing: Text(
                  '$grams г',
                  style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _noteCtrl,
            enabled: !_ordered,
            onChanged: _onNoteChanged,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.edit_note),
              labelText: 'Побажання до замовлення',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // Лічильник порцій: [-] N [+]
  Widget _buildServingsSelector(ThemeData theme) {
    return Row(
      children: [
        Text(
          'Порцій:',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton.filledTonal(
          tooltip: 'Менше',
          onPressed: (_ordered || _servings <= 1) ? null : _onDecrement,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 48,
          child: Center(
            child: Text(
              '$_servings',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Більше',
          onPressed: (_ordered || _servings >= _maxServings) ? null : _onIncrement,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _statCard(
    ThemeData theme,
    ColorScheme colorScheme,
    IconData icon,
    String text, {
    Color? iconColor,
  }) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Icon(icon, size: 20, color: iconColor ?? colorScheme.primary),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(text, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }

  // Row: ціна + Spacer + ElevatedButton
  Widget _buildOrderBar(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _ordered ? 'Замовлено ✓' : 'Ціна:',
                style: theme.textTheme.labelMedium,
              ),
              Text(
                '₴ $_totalPrice',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              backgroundColor: _ordered ? colorScheme.secondary : colorScheme.primary,
              foregroundColor: _ordered ? colorScheme.onSecondary : colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _onOrderPressed,
            icon: Icon(_ordered ? Icons.close : Icons.shopping_bag_outlined),
            label: Text(
              _ordered ? 'Скасувати' : 'Замовити',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
