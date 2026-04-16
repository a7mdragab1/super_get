import 'package:flutter/material.dart';
import 'package:super_get/super_get.dart';

import 'api_demo_controller.dart';

class ApiDemoPage extends StatelessWidget {
  const ApiDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ApiDemoController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload',
            onPressed: c.fetchUsers,
          ),
        ],
      ),
      body: c.obx(
        // Success state
        (users) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: users!.length,
          itemBuilder: (_, i) {
            final user = users[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    user.name[0],
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(user.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.email_rounded,
                            size: 14, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(user.email,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.business_rounded,
                            size: 14, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Text(user.company,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: Icon(Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant),
                onTap: () {
                  Get.snackbar(
                    user.name,
                    '${user.email} • ${user.company}',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            );
          },
        ),

        // Loading state
        onLoading: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Fetching users from API...'),
            ],
          ),
        ),

        // Error state
        onError: (error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_rounded,
                    size: 64, color: colorScheme.error),
                const SizedBox(height: 16),
                Text('Something went wrong',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  error ?? 'Unknown error',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: c.fetchUsers,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),

        // Empty state
        onEmpty: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline_rounded,
                  size: 64, color: colorScheme.outlineVariant),
              const SizedBox(height: 16),
              const Text('No users found'),
            ],
          ),
        ),
      ),
    );
  }
}
