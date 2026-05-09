import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_container.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/features/auth/application/login_notifier.dart';
import 'package:sahada_dev/features/auth/application/login_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Ekran yüksekliğinin %10'u kadar üstten boşluk
              final topPadding = constraints.maxHeight * 0.10;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  top: topPadding,
                  bottom: AppSpacing.xl,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 336,
                  ), // 420 * 0.8 = 336 (%20 küçültüldü)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      _buildLogo(),
                      const SizedBox(
                        height: 33.6,
                      ), // 48 * 0.7 = 33.6 (%30 azaltıldı)
                      // Glass container
                      GlassContainer(
                        padding: const EdgeInsets.all(
                          25.6,
                        ), // AppSpacing.xxxl (32) * 0.8 = 25.6
                        child: Column(
                          children: [
                            // Title
                            _buildTitle(state),
                            const SizedBox(height: AppSpacing.xl),

                            // Form based on step
                            if (state.step == LoginStep.phone)
                              _buildPhoneForm(context, state, notifier)
                            else
                              _buildOtpForm(context, state, notifier),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'public/assets/YOROS1.png',
      height: 120,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTitle(LoginState state) {
    String title;
    String subtitle;

    if (state.step == LoginStep.phone) {
      title = state.authMode == AuthMode.login ? 'Giriş Yap' : 'Kayıt Ol';
      subtitle = state.authMode == AuthMode.login
          ? 'Hesabınıza giriş yapmak için telefon numaranızı girin'
          : 'Kayıt için bilgilerinizi girin';
    } else {
      title = 'Telefon Doğrulama';
      final digits = state.phone.replaceAll(RegExp(r'\D'), '');
      subtitle = '+90$digits numarasına gelen kodu girin';
    }

    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 19.2, // 24 * 0.8 = 19.2
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 9.6,
            color: AppColors.textTertiary,
          ), // 12 * 0.8 = 9.6
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPhoneForm(
    BuildContext context,
    LoginState state,
    LoginNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Sol hizalama
      children: [
        // Auth mode toggle with animated background
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brMd,
            border: Border.all(color: AppColors.glassBorderSoft),
          ),
          child: Stack(
            children: [
              // Animated background indicator
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: state.authMode == AuthMode.login
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryBright,
                      borderRadius: AppRadii.brSm,
                    ),
                    height: 32, // AppSpacing.sm * 4
                  ),
                ),
              ),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildModeButton(
                      'Giriş Yap',
                      state.authMode == AuthMode.login,
                      () => notifier.setAuthMode(AuthMode.login),
                    ),
                  ),
                  Expanded(
                    child: _buildModeButton(
                      'Kayıt Ol',
                      state.authMode == AuthMode.signup,
                      () => notifier.setAuthMode(AuthMode.signup),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Form fields - Her iki mod için de aynı alanlar (AnimatedSize ile smooth geçiş)
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter, // Üstten sabit, alta doğru büyüme
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Signup fields (Ad, Soyad)
              if (state.authMode == AuthMode.signup) ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Ad',
                        value: state.firstName,
                        onChanged: notifier.setFirstName,
                        icon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _buildTextField(
                        label: 'Soyad',
                        value: state.lastName,
                        onChanged: notifier.setLastName,
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // E-posta field (Her iki modda da var)
              _buildTextField(
                label: 'E-posta adresi',
                value: state.email,
                onChanged: notifier.setEmail,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Phone field - TEMPORARILY DISABLED
        // _buildPhoneField(state, notifier),
        // const SizedBox(height: AppSpacing.lg),

        // Error message
        if (state.error != null) ...[
          _buildErrorMessage(state.error!),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Submit button
        GradientButton(
          onPressed: state.isLoading
              ? null
              : () => notifier.handlePhoneSubmit(),
          label: state.authMode == AuthMode.login
              ? 'Giriş Kodu Gönder'
              : 'Kayıt Ol ve Kod Gönder',
          isLoading: state.isLoading,
        ),
      ],
    );
  }

  Widget _buildOtpForm(
    BuildContext context,
    LoginState state,
    LoginNotifier notifier,
  ) {
    return Column(
      children: [
        // OTP input field (single field for 6 digits)
        Text(
          'TELEFON DOĞRULAMA KODU',
          style: GoogleFonts.inter(
            fontSize: 8.8, // 11 * 0.8 = 8.8
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 9.6), // 12 * 0.8 = 9.6
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(9.6), // 12 * 0.8 = 9.6
            border: Border.all(
              color: state.otp.length == 6
                  ? const Color(0xFFa3e635).withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: TextField(
            onChanged: (value) {
              notifier.setOtp(value);
              // Auto-submit when 6 digits entered
              if (value.length == 6 && !state.isLoading) {
                notifier.handleOtpSubmit().then((success) {
                  if (success && context.mounted) {
                    // Yeni kayıt ise profil oluşturma ekranına git
                    if (state.authMode == AuthMode.signup) {
                      context.go('/profile-setup');
                    } else {
                      // Giriş ise explore'a git
                      context.go('/explore');
                    }
                  }
                });
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 19.2, // 24 * 0.8 = 19.2
              fontWeight: FontWeight.bold,
              letterSpacing: 6.4, // 8 * 0.8 = 6.4
            ),
            decoration: InputDecoration(
              hintText: '• • • • • •',
              hintStyle: GoogleFonts.robotoMono(
                color: Colors.white.withValues(alpha: 0.2),
                fontSize: 19.2, // 24 * 0.8 = 19.2
                letterSpacing: 6.4, // 8 * 0.8 = 6.4
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16), // 20 * 0.8 = 16
            ),
          ),
        ),
        const SizedBox(height: 19.2), // 24 * 0.8 = 19.2
        // Dev code display (if available)
        if (state.devCode != null) ...[
          Container(
            padding: const EdgeInsets.all(9.6), // 12 * 0.8 = 9.6
            decoration: BoxDecoration(
              color: const Color(0xFFa3e635).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(9.6), // 12 * 0.8 = 9.6
              border: Border.all(
                color: const Color(0xFFa3e635).withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'GELİŞTİRİCİ MODU',
                  style: GoogleFonts.inter(
                    fontSize: 8, // 10 * 0.8 = 8
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFa3e635).withValues(alpha: 0.6),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 6.4), // 8 * 0.8 = 6.4
                Text(
                  state.devCode!,
                  style: GoogleFonts.robotoMono(
                    fontSize: 16, // 20 * 0.8 = 16
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3.2, // 4 * 0.8 = 3.2
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.8), // 16 * 0.8 = 12.8
        ],

        // Error message
        if (state.error != null) ...[
          _buildErrorMessage(state.error!),
          const SizedBox(height: 12.8), // 16 * 0.8 = 12.8
        ],

        // Submit button
        GradientButton(
          onPressed: state.isLoading
              ? null
              : () async {
                  final success = await notifier.handleOtpSubmit();
                  if (success && context.mounted) {
                    // Yeni kayıt ise profil oluşturma ekranına git
                    if (state.authMode == AuthMode.signup) {
                      context.go('/profile-setup');
                    } else {
                      // Giriş ise explore'a git
                      context.go('/explore');
                    }
                  }
                },
          label: state.authMode == AuthMode.login
              ? 'Sisteme Gir'
              : 'Hesabı Oluştur',
          isLoading: state.isLoading,
        ),
        const SizedBox(height: 9.6), // 12 * 0.8 = 9.6
        // Back button
        TextButton(
          onPressed: notifier.resetToPhoneStep,
          child: Text(
            'Kodu Yeniden Al / Bilgileri Düzenle',
            style: GoogleFonts.inter(
              fontSize: 9.6, // 12 * 0.8 = 9.6
              color: Colors.white.withValues(alpha: 0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: const BoxDecoration(
          color: Colors
              .transparent, // Arka plan yok, Stack'teki animated container gösterecek
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 9.6, // 12 * 0.8 = 9.6
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : AppColors.textTertiary,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brMd,
            border: Border.all(color: AppColors.glassBorderSoft),
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 11.2, // 14 * 0.8 = 11.2
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 11.2, // 14 * 0.8 = 11.2
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.textTertiary,
                size: 16,
              ), // 20 * 0.8 = 16
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(
                12.8,
              ), // AppSpacing.lg (16) * 0.8 = 12.8
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(9.6), // AppSpacing.md (12) * 0.8 = 9.6
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.1),
        borderRadius: AppRadii.brMd,
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 4.8, // 6 * 0.8 = 4.8
            height: 4.8, // 6 * 0.8 = 4.8
            decoration: BoxDecoration(
              color: AppColors.danger,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.danger.withValues(alpha: 0.8),
                  blurRadius: 8, // 10 * 0.8 = 8
                ),
              ],
            ),
          ),
          const SizedBox(width: 9.6), // AppSpacing.md (12) * 0.8 = 9.6
          Expanded(
            child: Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 9.6, // 12 * 0.8 = 9.6
                color: AppColors.danger,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
