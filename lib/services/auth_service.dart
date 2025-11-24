import 'package:supabase_flutter/supabase_flutter.dart';

/// Simple AuthService wrapper around a Supabase client.
/// The class intentionally keeps a minimal surface required for signup.
class AuthService {
  AuthService({required this.client});

  /// Use a dynamic client type to keep the wrapper small and easy to test.
  final dynamic client;

  /// Sign up using Supabase auth with `email`, `password` and `username` stored
  /// in the user metadata via the `data` parameter.
  Future<dynamic> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );

    return response;
  }

  /// Proxy to signOut for convenience.
  Future<void> signOut() => client.auth.signOut();
}
