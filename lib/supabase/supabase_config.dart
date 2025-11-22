import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://hbypjqvegjjcngafhuhs.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhieXBqcXZlZ2pqY25nYWZodWhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM0NjE2MDQsImV4cCI6MjA3OTAzNzYwNH0.EUN0pNQvgjOZLtxD8SuMzfrM3tzcYSrX4JmPYsEg-8k';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
