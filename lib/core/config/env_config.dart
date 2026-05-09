import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration manager
/// Manages all environment variables and configuration
class EnvConfig {
  EnvConfig._();

  /// Initialize environment configuration
  /// Must be called before runApp()
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  /// Current environment (development, staging, production)
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'development';

  /// Supabase project URL
  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('SUPABASE_URL not found in .env file');
    }
    return url;
  }

  /// Supabase anonymous key
  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY not found in .env file');
    }
    return key;
  }

  /// Check if running in development mode
  static bool get isDevelopment => appEnv == 'development';

  /// Check if running in production mode
  static bool get isProduction => appEnv == 'production';

  /// Check if running in staging mode
  static bool get isStaging => appEnv == 'staging';
}
