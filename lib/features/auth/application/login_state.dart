import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

enum LoginStep { phone, otp }

enum AuthMode { login, signup }

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStep.phone) LoginStep step,
    @Default(AuthMode.login) AuthMode authMode,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String otp,
    @Default(false) bool isLoading,
    String? error,
  }) = _LoginState;
}
