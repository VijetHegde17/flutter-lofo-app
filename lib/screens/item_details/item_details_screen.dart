import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/item_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});

  final ItemModel item;

  Future<void> _callContact() async {
    final uri = Uri(scheme: 'tel', path: item.contact);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _copyContact(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: item.contact));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact copied')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (item.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl!,
                height: 240,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: Icon(
                Icons.image_outlined,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(height: 24),
          Text(
            item.description,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_pin),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.location,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Posted on ${DateFormat.yMMMMd().format(item.createdAt)}',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _callContact,
            icon: const Icon(Icons.call),
            label: const Text('Call contact'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _copyContact(context),
            icon: const Icon(Icons.copy),
            label: const Text('Copy contact'),
          ),
        ],
      ),
    );
  }
}

