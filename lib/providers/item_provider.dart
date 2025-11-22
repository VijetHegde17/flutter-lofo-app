import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/item_model.dart';
import '../supabase/item_service.dart';
import '../supabase/auth_service.dart';
import 'auth_provider.dart';

// Item service provider
final itemServiceProvider = Provider<SupabaseItemService>(
  (ref) => SupabaseItemService(ref.watch(supabaseClientProvider)),
);

// Lost items stream provider
final lostItemsProvider = StreamProvider<List<ItemModel>>(
  (ref) => ref.watch(itemServiceProvider).watchItems(ItemType.lost),
);

// Found items stream provider
final foundItemsProvider = StreamProvider<List<ItemModel>>(
  (ref) => ref.watch(itemServiceProvider).watchItems(ItemType.found),
);

// Item controller for managing item operations
class ItemController extends StateNotifier<AsyncValue<void>> {
  ItemController(
    this._itemService,
    this._authService,
  ) : super(const AsyncData(null));

  final SupabaseItemService _itemService;
  final SupabaseAuthService _authService;

  Future<bool> addItem({
    required ItemType type,
    required String title,
    required String description,
    required String location,
    required String contact,
    required XFile? image,
  }) async {
    final user = _authService.currentUser;
    if (user == null) {
      state = AsyncError('User not authenticated', StackTrace.current);
      return false;
    }

    state = const AsyncLoading();
    try {
      final itemId = _itemService.generateItemId();
      final imageUrl = await _itemService.uploadItemImage(
        image,
        userId: user.id,
      );

      final item = ItemModel(
        id: itemId,
        title: title,
        description: description,
        location: location,
        contact: contact,
        type: type,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        userId: user.id,
      );

      await _itemService.addItem(item);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}

final itemControllerProvider =
    StateNotifierProvider<ItemController, AsyncValue<void>>(
  (ref) => ItemController(
    ref.watch(itemServiceProvider),
    ref.watch(authServiceProvider),
  ),
);
