import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

import 'todo_controller.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<TodoController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          Obx(() => c.doneCount > 0
              ? TextButton.icon(
                  onPressed: c.clearDone,
                  icon: const Icon(Icons.cleaning_services_rounded, size: 18),
                  label: const Text('Clear done'),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Column(
        children: [
          // Input field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                    ),
                    onSubmitted: (val) {
                      c.addTodo(val);
                      textController.clear();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    c.addTodo(textController.text);
                    textController.clear();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Filter chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Obx(() => Row(
                  children: [
                    _FilterChip(
                      label: 'All (${c.todos.length})',
                      selected: c.filter.value == 'all',
                      onTap: () => c.filter.value = 'all',
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Active (${c.activeCount})',
                      selected: c.filter.value == 'active',
                      onTap: () => c.filter.value = 'active',
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Done (${c.doneCount})',
                      selected: c.filter.value == 'done',
                      onTap: () => c.filter.value = 'done',
                    ),
                  ],
                )),
          ),

          const Divider(),

          // Todo list
          Expanded(
            child: Obx(() {
              final items = c.filteredTodos;
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inbox_rounded,
                          size: 64, color: colorScheme.outlineVariant),
                      const SizedBox(height: 12),
                      Text(
                        c.todos.isEmpty
                            ? 'No tasks yet — add one above!'
                            : 'No ${c.filter.value} tasks.',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final todo = items[i];
                  return Dismissible(
                    key: ValueKey(todo.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: colorScheme.errorContainer,
                      child: Icon(Icons.delete_rounded,
                          color: colorScheme.error),
                    ),
                    onDismissed: (_) => c.removeTodo(todo.id),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) => c.toggleTodo(todo.id),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isDone
                                ? colorScheme.onSurfaceVariant
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
