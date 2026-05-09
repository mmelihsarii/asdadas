import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService.instance;
});

/// Authentication service
/// Handles all authentication operations
class AuthService {
  AuthService._();

  static AuthService? _instance;
  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  final _supabase = SupabaseService.instance;

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: metadata,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  /// Update user password
  Future<UserResponse> updatePassword({required String newPassword}) async {
    return await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  /// Update user metadata
  Future<UserResponse> updateUserMetadata({
    required Map<String, dynamic> metadata,
  }) async {
    return await _supabase.auth.updateUser(UserAttributes(data: metadata));
  }

  /// Get current session
  Session? get currentSession => _supabase.auth.currentSession;

  /// Get current user
  User? get currentUser => _supabase.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _supabase.isAuthenticated;

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Sign in with phone OTP
  Future<void> signInWithOtp(String phone) async {
    await _supabase.auth.signInWithOtp(phone: phone, shouldCreateUser: true);
  }

  /// Sign in with email magic link (OTP)
  Future<void> signInWithEmailOtp(String email) async {
    await _supabase.auth.signInWithOtp(email: email, shouldCreateUser: true);
  }

  /// Verify OTP code
  Future<AuthResponse> verifyOtp(String phone, String token) async {
    return await _supabase.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }
}
