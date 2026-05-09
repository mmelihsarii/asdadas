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
    state = state.copyWith(
      step: LoginStep.phone,
      otp: '',
      error: null,
      devCode: null,
    );
  }

  bool _validatePhone() {
    final digits = state.phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) {
      state = state.copyWith(
        error: 'Lütfen geçerli bir numara girin. Format: (5XX) XXX XX XX',
      );
      return false;
    }
    if (!digits.startsWith('5')) {
      state = state.copyWith(error: 'Telefon numarası 5 ile başlamalıdır.');
      return false;
    }
    return true;
  }

  bool _validateSignupFields() {
    if (state.firstName.trim().isEmpty || state.lastName.trim().isEmpty) {
      state = state.copyWith(error: 'Lütfen ad ve soyad girin.');
      return false;
    }
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(state.email.trim().toLowerCase())) {
      state = state.copyWith(error: 'Lütfen geçerli bir e-posta adresi girin.');
      return false;
    }
    return true;
  }

  Future<void> handlePhoneSubmit() async {
    state = state.copyWith(error: null, devCode: null);

    // TEMPORARILY DISABLED - Phone verification bypassed
    // if (!_validatePhone()) return;

    if (state.authMode == AuthMode.signup) {
      if (!_validateSignupFields()) return;
    } else {
      // For login, just validate email
      final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      if (!emailRegex.hasMatch(state.email.trim().toLowerCase())) {
        state = state.copyWith(
          error: 'Lütfen geçerli bir e-posta adresi girin.',
        );
        return;
      }
    }

    state = state.copyWith(isLoading: true);

    try {
      // DEVELOPMENT MODE - Generate a mock OTP code
      final mockOtpCode = '123456'; // Fixed code for development
      print('═══════════════════════════════════════════════════');
      print('🔐 DEVELOPMENT MODE - EMAIL OTP CODE');
      print('═══════════════════════════════════════════════════');
      print('Email: ${state.email.trim().toLowerCase()}');
      print('OTP Code: $mockOtpCode');
      print('═══════════════════════════════════════════════════');

      // TEMPORARILY DISABLED - Email OTP sending
      // await _authService.signInWithEmailOtp(state.email.trim().toLowerCase());

      state = state.copyWith(
        step: LoginStep.otp,
        otp: '',
        isLoading: false,
        devCode: mockOtpCode, // Show code in UI
        error: null,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<bool> handleOtpSubmit() async {
    state = state.copyWith(error: null, isLoading: true);

    try {
      // DEVELOPMENT MODE - Mock OTP verification
      if (state.otp == '123456') {
        print('✅ OTP verification successful (DEV MODE)');

        // Başarılı - router otomatik yönlendirecek
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          error: 'Geçersiz kod. Lütfen 123456 kodunu girin (DEV MODE)',
          isLoading: false,
        );
        return false;
      }

      // REAL IMPLEMENTATION (commented out for dev mode)
      // final digits = state.phone.replaceAll(RegExp(r'\D'), '');
      // final fullPhone = '+90$digits';
      // await _authService.verifyOtp(fullPhone, state.otp);
      // state = state.copyWith(isLoading: false);
      // return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Doğrulama başarısız: ${e.toString()}',
        isLoading: false,
      );
      return false;
    }
  }
}
