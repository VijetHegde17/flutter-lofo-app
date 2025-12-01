// lib/supabase/env.dart
// Do NOT put real keys here. Use build-time environment variables or GitHub Secrets.
class SupabaseEnv {
  // Read from Dart define environment variables. These are set at build/run time.
  static const String supabaseUrl =
      String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
}
