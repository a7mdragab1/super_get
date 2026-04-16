import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

class TodoItem {
  final String id;
  final String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false})
      : id = DateTime.now().microsecondsSinceEpoch.toString();
}

class TodoController extends GetxController {
  final todos = <TodoItem>[].obs;
  final filter = 'all'.obs; // 'all', 'active', 'done'

  List<TodoItem> get filteredTodos {
    switch (filter.value) {
      case 'active':
        return todos.where((t) => !t.isDone).toList();
      case 'done':
        return todos.where((t) => t.isDone).toList();
      default:
        return todos.toList();
    }
  }

  int get activeCount => todos.where((t) => !t.isDone).length;
  int get doneCount => todos.where((t) => t.isDone).length;

  @override
  void onInit() {
    super.onInit();

    // Worker: notify when all todos are completed
    ever(todos, (_) {
      if (todos.isNotEmpty && todos.every((t) => t.isDone)) {
        Get.snackbar(
          '🎊 All Done!',
          'You\'ve completed every task. Great job!',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    todos.add(TodoItem(title: title.trim()));
  }

  void toggleTodo(String id) {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index].isDone = !todos[index].isDone;
      todos.refresh();
    }
  }

  void removeTodo(String id) {
    final item = todos.firstWhere((t) => t.id == id);
    todos.removeWhere((t) => t.id == id);
    Get.snackbar(
      'Removed',
      '"${item.title}" was deleted.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      mainButton: TextButton(
        onPressed: () {
          todos.add(item);
          Get.closeCurrentSnackbar();
        },
        child: const Text('UNDO'),
      ),
    );
  }

  void clearDone() {
    final count = doneCount;
    todos.removeWhere((t) => t.isDone);
    Get.snackbar(
      'Cleared',
      'Removed $count completed tasks.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
