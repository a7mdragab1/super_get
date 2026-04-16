import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

import 'pages/home/home_page.dart';
import 'pages/home/home_binding.dart';
import 'pages/counter/counter_page.dart';
import 'pages/counter/counter_binding.dart';
import 'pages/todo/todo_page.dart';
import 'pages/todo/todo_binding.dart';
import 'pages/api/api_demo_page.dart';
import 'pages/api/api_demo_binding.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SuperGetDemoApp());
}

class SuperGetDemoApp extends StatelessWidget {
  const SuperGetDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Super Get Showcase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/counter',
          page: () => const CounterPage(),
          binding: CounterBinding(),
        ),
        GetPage(
          name: '/todo',
          page: () => const TodoPage(),
          binding: TodoBinding(),
        ),
        GetPage(
          name: '/api',
          page: () => const ApiDemoPage(),
          binding: ApiDemoBinding(),
        ),
      ],
    );
  }
}
