import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/item_model.dart';

class SupabaseItemService {
  final SupabaseClient _client;

  SupabaseItemService(this._client);

  // Watch items stream
  Stream<List<ItemModel>> watchItems(ItemType type) {
    return _client
        .from('items')
        .stream(primaryKey: ['id'])
        .eq('type', type.label.toLowerCase())
        .order('created_at', ascending: false)
        .map((data) => data.map((item) => ItemModel.fromJson(item, type)).toList());
  }

  // Add new item
  Future<void> addItem(ItemModel item) async {
    await _client.from('items').insert(item.toJson());
  }

  // Upload image to Supabase Storage
  Future<String?> uploadItemImage(
    XFile? file, {
    required String userId,
  }) async {
    if (file == null) return null;

    final bytes = await file.readAsBytes();
    final fileExt = file.name.split('.').last;
    final fileName = '${const Uuid().v4()}.$fileExt';
    final filePath = 'items/$userId/$fileName';

    await _client.storage.from('item-images').uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(
            contentType: file.mimeType ?? 'image/jpeg',
          ),
        );

    final publicUrl = _client.storage.from('item-images').getPublicUrl(filePath);
    return publicUrl;
  }

  // Generate unique item ID
  String generateItemId() {
    return const Uuid().v4();
  }
}
