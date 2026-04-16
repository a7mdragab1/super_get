import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

class HomeController extends GetxController {
  final isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
