import 'package:supabase_flutter/supabase_flutter.dart';

/// A small service wrapper around Supabase client for lost items.
///
/// The client is typed as `dynamic` to keep the implementation simple and
/// allow easier unit testing (mocks/fakes can be passed in tests).
class LostService {
  final dynamic client;

  LostService(this.client);

  Future<void> addLostItem({
    required String name,
    required String description,
    required String location,
    required String imageUrl,
  }) async {
    await client.from('lost_items').insert({
      'name': name,
      'description': description,
      'location': location,
      'image_url': imageUrl,
    });
  }
}
