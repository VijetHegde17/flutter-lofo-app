import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase/supabase_config.dart';
import '../supabase/auth_service.dart';

// Supabase client provider
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => SupabaseConfig.client,
);

// Auth service provider
final authServiceProvider = Provider<SupabaseAuthService>(
  (ref) => SupabaseAuthService(ref.watch(supabaseClientProvider)),
);

// Auth state changes provider
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges().map((state) => state.session?.user);
});

// Auth controller for managing auth operations
class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._authService) : super(const AsyncData(null));

  final SupabaseAuthService _authService;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await _authService.signIn(email: email, password: password);
      state = const AsyncData(null);
    } on AuthException catch (error, stackTrace) {
      state = AsyncError(error.message, stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      state = AsyncError('Login failed: $error', stackTrace);
      rethrow;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await _authService.signUp(email: email, password: password);
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
