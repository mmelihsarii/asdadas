import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/features/profile/application/current_user_provider.dart';
import 'package:sahada_dev/features/profile/application/profile_edit_provider.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _avatarFile;
  bool _isInitialized = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final editState = ref.watch(profileEditProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Profili Düzenle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: userAsync.when(
            data: (user) {
              if (user == null) {
                return Center(
                  child: Text(
                    'Kullanıcı bulunamadı',
                    style: GoogleFonts.inter(color: AppColors.textSecondary),
                  ),
                );
              }

              // Initialize form with current user data
              if (!_isInitialized) {
                _displayNameController.text = user.displayName ?? '';
                _phoneController.text = user.phone ?? '';
                _isInitialized = true;
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Avatar Section
                      _buildAvatarSection(user.avatarUrl),
                      const SizedBox(height: AppSpacing.xl),

                      // Display Name Field
                      _buildDisplayNameField(),
                      const SizedBox(height: AppSpacing.lg),

                      // Phone Field
                      _buildPhoneField(),
                      const SizedBox(height: AppSpacing.lg),

                      // Email (Read-only)
                      _buildEmailField(user.email ?? ''),
                      const SizedBox(height: AppSpacing.xl),

                      // Error Message
                      if (editState.hasError) ...[
                        _buildErrorMessage(editState.error.toString()),
                        const SizedBox(height: AppSpacing.lg),
                      ],

                      // Save Button
                      _buildSaveButton(),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryBright,
                ),
              ),
            ),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.danger,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Hata: $error',
                    style: GoogleFonts.inter(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(String? currentAvatarUrl) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickAvatar,
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surface,
                    border: Border.all(
                      color: AppColors.glassBorderMedium,
                      width: 2,
                    ),
                    image: _avatarFile != null
                        ? DecorationImage(
                            image: FileImage(_avatarFile!),
                            fit: BoxFit.cover,
                          )
                        : currentAvatarUrl != null
                        ? DecorationImage(
                            image: NetworkImage(currentAvatarUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _avatarFile == null && currentAvatarUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.textTertiary,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: AppColors.gradientPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Fotoğrafı Değiştir',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayNameField() {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kullanıcı Adı *',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _displayNameController,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Kullanıcı adını girin',
              hintStyle: GoogleFonts.inter(color: AppColors.textMuted),
              filled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Kullanıcı adı gerekli';
              }
              if (value.trim().length < 2) {
                return 'Kullanıcı adı en az 2 karakter olmalı';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Telefon',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Telefon numaranızı girin',
              hintStyle: GoogleFonts.inter(color: AppColors.textMuted),
              filled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(String email) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'E-posta',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.glassTintLight,
                  borderRadius: AppRadii.brSm,
                ),
                child: Text(
                  'Değiştirilemez',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            email,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.1),
        borderRadius: AppRadii.brMd,
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.danger, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              error,
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    final editState = ref.watch(profileEditProvider);

    return GradientButton(
      onPressed: editState.isLoading ? null : _handleSave,
      label: 'Kaydet',
      isLoading: editState.isLoading,
    );
  }

  Future<void> _pickAvatar() async {
    final file = await ref.read(profileEditProvider.notifier).pickAvatar();
    if (file != null) {
      setState(() {
        _avatarFile = file;
      });
    }
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState?.validate() != true) return;

    final success = await ref
        .read(profileEditProvider.notifier)
        .updateProfile(
          displayName: _displayNameController.text.trim(),
          phone: _phoneController.text.trim(),
          avatarFile: _avatarFile,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil başarıyla güncellendi',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }
}
