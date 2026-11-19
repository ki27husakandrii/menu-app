import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/use_cases/filter_by_category.dart';
import 'application/use_cases/get_categories.dart';
import 'application/use_cases/get_menu_items.dart';
import 'config/app_config.dart';
import 'domain/repositories/menu_repository.dart';
import 'infrastructure/repositories/in_memory_menu_repository.dart';
import 'presentation/notifiers/menu_notifier.dart';
import 'presentation/screens/menu_screen.dart';

void main() {
  // Dependency Injection: єдине місце, де відомо про конкретну реалізацію.
  // Щоб змінити спосіб зберігання даних, достатньо замінити цей рядок.
  final MenuRepository repository = InMemoryMenuRepository();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final MenuRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuNotifier(
            getMenuItems: GetMenuItems(repository),
            getCategories: GetCategories(repository),
            filterByCategory: FilterByCategory(repository),
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConfig.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.light,
          ),
        ),
        home: const MenuScreen(),
      ),
    );
  }
}
