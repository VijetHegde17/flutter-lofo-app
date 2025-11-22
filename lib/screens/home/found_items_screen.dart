import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/item_provider.dart';
import '../../widgets/item_card.dart';
import '../item_details/item_details_screen.dart';

class FoundItemsScreen extends ConsumerWidget {
  const FoundItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(foundItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Found items')),
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No found items have been posted.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCard(
                item: item,
                subtitle:
                    'Found in ${item.location} • ${DateFormat.yMMMd().format(item.createdAt)}',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ItemDetailsScreen(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Error loading found items: $error'),
        ),
      ),
    );
  }
}

