import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/config/env_config.dart';
import 'core/services/supabase_service.dart';
// import 'core/utils/supabase_test.dart'; // Uncomment to run tests

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration
  await EnvConfig.init();

  // Initialize Supabase
  await SupabaseService.initialize();

  // 🧪 DEVELOPMENT: Supabase bağlantı testleri (opsiyonel)
  // Uncomment to test Supabase connection on app start
  // await SupabaseTest.runAllTests();

  runApp(const ProviderScope(child: SahadaApp()));
}
