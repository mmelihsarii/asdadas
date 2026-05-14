import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahada_dev/core/services/auth_service.dart';
import 'package:sahada_dev/features/auth/application/login_state.dart';

final loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
      return LoginNotifier(ref.read(authServiceProvider));
    });

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._authService) : super(const LoginState());

  final AuthService _authService;

  static final _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  void setAuthMode(AuthMode mode) {
    state = state.copyWith(authMode: mode, error: null);
  }

  void setFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void setLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value);
  }

  void setOtp(String value) {
    state = state.copyWith(otp: value);
  }

  void resetToPhoneStep() {
    state = state.copyWith(step: LoginStep.phone, otp: '', error: null);
  }

  bool _validateEmail() {
    if (!_emailRegex.hasMatch(state.email.trim().toLowerCase())) {
      state = state.copyWith(error: 'Lütfen geçerli bir e-posta adresi girin.');
      return false;
    }
    return true;
  }

  bool _validateSignupFields() {
    if (state.firstName.trim().isEmpty || state.lastName.trim().isEmpty) {
      state = state.copyWith(error: 'Lütfen ad ve soyad girin.');
      return false;
    }
    return _validateEmail();
  }

  Future<void> handlePhoneSubmit() async {
    state = state.copyWith(error: null);

    final isSignup = state.authMode == AuthMode.signup;
    if (isSignup ? !_validateSignupFields() : !_validateEmail()) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final email = state.email.trim().toLowerCase();
      final fullName = '${state.firstName.trim()} ${state.lastName.trim()}'
          .trim();

      await _authService.signInWithEmailOtp(
        email,
        shouldCreateUser: isSignup,
        metadata: isSignup
            ? {
                'name': fullName,
                'display_name': fullName,
                'first_name': state.firstName.trim(),
                'last_name': state.lastName.trim(),
                'phone': state.phone.trim().isEmpty
                    ? email
                    : state.phone.trim(),
              }
            : null,
      );

      state = state.copyWith(
        step: LoginStep.otp,
        otp: '',
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Kod gönderilemedi: ${_friendlyAuthError(e)}',
        isLoading: false,
      );
    }
  }

  Future<bool> handleOtpSubmit() async {
    state = state.copyWith(error: null, isLoading: true);

    try {
      final email = state.email.trim().toLowerCase();
      await _authService.verifyOtp(email, state.otp);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Doğrulama başarısız: ${_friendlyAuthError(e)}',
        isLoading: false,
      );
      return false;
    }
  }

  String _friendlyAuthError(Object error) {
    final message = error.toString();
    final lower = message.toLowerCase();

    if (lower.contains('rate limit') ||
        lower.contains('over_email_send_rate_limit') ||
        lower.contains('too many')) {
      return 'E-posta gönderim limiti doldu. Son gelen kodu kullanın veya kısa süre sonra tekrar deneyin.';
    }

    if (lower.contains('otp') || lower.contains('token')) {
      return 'Kod hatalı veya süresi dolmuş olabilir.';
    }

    if (lower.contains('signup') || lower.contains('user not found')) {
      return 'Bu e-posta için hesap bulunamadı. Önce kayıt olun.';
    }

    return message;
  }
}
