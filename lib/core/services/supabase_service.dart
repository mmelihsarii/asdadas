import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

/// Supabase service singleton
/// Centralized Supabase client management
class SupabaseService {
  SupabaseService._();

  static SupabaseService? _instance;
  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  /// Initialize Supabase
  /// Must be called after EnvConfig.init() and before runApp()
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
      debug: EnvConfig.isDevelopment,
    );
  }

  /// Get Supabase client instance
  SupabaseClient get client => Supabase.instance.client;

  /// Get Auth instance
  GoTrueClient get auth => client.auth;

  /// Get Database instance
  PostgrestClient get database => client.from('') as PostgrestClient;

  /// Get Storage instance
  SupabaseStorageClient get storage => client.storage;

  /// Get Realtime instance
  RealtimeClient get realtime => client.realtime;

  /// Check if user is authenticated
  bool get isAuthenticated => auth.currentUser != null;

  /// Get current user
  User? get currentUser => auth.currentUser;

  /// Get current user ID
  String? get currentUserId => auth.currentUser?.id;
}
