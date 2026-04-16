import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 Super Get Showcase'),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                icon: Icon(c.isDarkMode.value
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded),
                tooltip: 'Toggle theme',
                onPressed: c.toggleTheme,
              )),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header
          Text(
            'Explore Super Get Features',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap any card below to see the feature in action.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),

          // Feature cards
          _FeatureCard(
            icon: Icons.add_circle_outline_rounded,
            title: 'Reactive Counter',
            subtitle: 'Obx, .obs, GetxController',
            color: colorScheme.primaryContainer,
            iconColor: colorScheme.primary,
            onTap: () => Get.toNamed('/counter'),
          ),
          const SizedBox(height: 12),
          _FeatureCard(
            icon: Icons.checklist_rounded,
            title: 'Todo List',
            subtitle: 'RxList, Workers, Snackbars',
            color: colorScheme.secondaryContainer,
            iconColor: colorScheme.secondary,
            onTap: () => Get.toNamed('/todo'),
          ),
          const SizedBox(height: 12),
          _FeatureCard(
            icon: Icons.cloud_download_rounded,
            title: 'API Demo',
            subtitle: 'GetConnect, Rx status, Error handling',
            color: colorScheme.tertiaryContainer,
            iconColor: colorScheme.tertiary,
            onTap: () => Get.toNamed('/api'),
          ),
          const SizedBox(height: 24),

          // Quick actions
          Text(
            'Quick Actions (No Context!)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    Get.snackbar(
                      '👋 Hello!',
                      'This snackbar needs no BuildContext.',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(12),
                      borderRadius: 12,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  icon: const Icon(Icons.notifications_active_rounded),
                  label: const Text('Snackbar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Super Get',
                      middleText: 'Dialogs without context — easy!',
                      textConfirm: 'Nice!',
                      confirmTextColor: colorScheme.onPrimary,
                      buttonColor: colorScheme.primary,
                      onConfirm: () => Get.back(),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_rounded),
                  label: const Text('Dialog'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Icon(Icons.rocket_launch_rounded,
                          size: 48, color: colorScheme.primary),
                      const SizedBox(height: 16),
                      Text(
                        'Bottom Sheet — No Context!',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Get.bottomSheet() works anywhere in your code.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => Get.back(),
                          child: const Text('Got it!'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.swipe_up_rounded),
            label: const Text('Bottom Sheet'),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            )),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
