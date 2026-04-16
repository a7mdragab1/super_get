import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

import 'counter_controller.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CounterController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive Counter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt_rounded),
            tooltip: 'Reset',
            onPressed: c.reset,
          ),
        ],
      ),
      body: Column(
        children: [
          // Counter display
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Text(
                          '${c.count}',
                          key: ValueKey(c.count.value),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                fontSize: 80,
                              ),
                        ),
                      )),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the buttons or try +5 / +10',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RoundButton(
                      icon: Icons.remove,
                      color: colorScheme.errorContainer,
                      iconColor: colorScheme.error,
                      onPressed: c.decrement,
                    ),
                    const SizedBox(width: 24),
                    _RoundButton(
                      icon: Icons.add,
                      color: colorScheme.primaryContainer,
                      iconColor: colorScheme.primary,
                      onPressed: c.increment,
                      size: 72,
                    ),
                    const SizedBox(width: 24),
                    _RoundButton(
                      icon: Icons.add,
                      color: colorScheme.secondaryContainer,
                      iconColor: colorScheme.secondary,
                      label: '+5',
                      onPressed: () => c.incrementBy(5),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    onPressed: () => c.incrementBy(10),
                    icon: const Icon(Icons.bolt_rounded),
                    label: const Text('+10 Turbo'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // History log
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.history_rounded,
                          size: 20, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Text(
                        'Change History (Workers)',
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Obx(() => c.history.isEmpty
                      ? Center(
                          child: Text(
                            'No changes yet — start tapping!',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: colorScheme.onSurfaceVariant),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: c.history.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final idx = c.history.length - 1 - i;
                            return ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                radius: 14,
                                backgroundColor: colorScheme.surfaceContainerHighest,
                                child: Text(
                                  '${idx + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                ),
                              ),
                              title: Text(c.history[idx]),
                            );
                          },
                        )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onPressed;
  final double size;
  final String? label;

  const _RoundButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onPressed,
    this.size = 56,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: label != null
              ? Text(label!,
                  style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))
              : Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
