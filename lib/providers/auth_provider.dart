import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';

// Supabase client provider using the global Supabase instance
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

// Auth service provider
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(client: ref.watch(supabaseClientProvider)),
);

// Auth controller for managing auth operations
class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._authService) : super(const AsyncData(null));

  final AuthService _authService;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncLoading();
    try {
      await _authService.signUp(
        email: email,
        password: password,
        username: username,
      );
      state = const AsyncData(null);
    } on AuthException catch (error, stackTrace) {
      state = AsyncError(error.message, stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      state = AsyncError('Signup failed: $error', stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() => _authService.signOut();
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>(
  (ref) => AuthController(ref.watch(authServiceProvider)),
);
