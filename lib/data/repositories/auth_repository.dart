import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

/// Authentication repository
/// Handles all auth operations with Supabase
class AuthRepository {
  final _supabase = SupabaseService.instance.client;

  /// Sign up with email (Magic Link / OTP)
  Future<void> signUpWithEmailOtp({
    required String email,
    required String name,
    String? phone,
    required String role,
    required String city,
    required String district,
  }) async {
    // Development mode: OTP kodunu console'da göster
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('🔐 OTP GÖNDERİLDİ (KAYIT)');
      debugPrint('📧 Email: $email');
      debugPrint('👤 İsim: $name');
      debugPrint('📱 Telefon: ${phone ?? "Yok"}');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('⚠️  OTP kodunu görmek için:');
      debugPrint('   1. Supabase Dashboard > Authentication > Logs');
      debugPrint('   2. En son "OTP sent" logunu aç');
      debugPrint('   3. 6 haneli kodu kopyala');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }

    // Send OTP to email
    await _supabase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: true,
      data: {
        'name': name,
        'phone': phone ?? email, // phone yoksa email kullan
        'role': role,
        'city': city,
        'district': district,
      },
    );

    // Development mode: Başarı mesajı
    if (kDebugMode) {
      debugPrint('✅ OTP başarıyla gönderildi!');
      debugPrint('');
    }
  }

  /// Sign in with email OTP
  Future<void> signInWithEmailOtp(String email) async {
    // Development mode: OTP kodunu console'da göster
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('🔐 OTP GÖNDERİLDİ (GİRİŞ)');
      debugPrint('📧 Email: $email');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('⚠️  OTP kodunu görmek için:');
      debugPrint('   1. Supabase Dashboard > Authentication > Logs');
      debugPrint('   2. En son "OTP sent" logunu aç');
      debugPrint('   3. 6 haneli kodu kopyala');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }

    await _supabase.auth.signInWithOtp(email: email, shouldCreateUser: false);

    // Development mode: Başarı mesajı
    if (kDebugMode) {
      debugPrint('✅ OTP başarıyla gönderildi!');
      debugPrint('');
    }
  }

  /// Verify OTP code
  Future<AuthResponse> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    // Development mode: Doğrulama denemesi
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('🔍 OTP DOĞRULANIYOR...');
      debugPrint('📧 Email: $email');
      debugPrint('🔢 Kod: $token');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }

    final response = await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.email,
    );

    // Development mode: Sonuç
    if (kDebugMode) {
      if (response.user != null) {
        debugPrint('✅ OTP DOĞRULANDI!');
        debugPrint('👤 Kullanıcı: ${response.user!.email}');
      } else {
        debugPrint('❌ OTP DOĞRULANAMADI!');
      }
      debugPrint('');
    }

    return response;
  }

  /// Sign in with phone OTP
  Future<void> signInWithPhoneOtp(String phone) async {
    await _supabase.auth.signInWithOtp(phone: phone, shouldCreateUser: true);
  }

  /// Verify phone OTP
  Future<AuthResponse> verifyPhoneOtp({
    required String phone,
    required String token,
  }) async {
    return await _supabase.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    required String city,
    required String district,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'phone': phone ?? email, // phone yoksa email kullan
        'role': role,
        'city': city,
        'district': district,
      },
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  /// Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  /// Get current user
  User? get currentUser => _supabase.auth.currentUser;

  /// Get current session
  Session? get currentSession => _supabase.auth.currentSession;

  /// Check if authenticated
  bool get isAuthenticated => _supabase.auth.currentUser != null;

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Refresh session
  Future<AuthResponse> refreshSession() async {
    return await _supabase.auth.refreshSession();
  }
}
