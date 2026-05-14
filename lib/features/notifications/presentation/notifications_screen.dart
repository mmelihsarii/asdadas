import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/data/models/models.dart';
import 'package:sahada_dev/features/notifications/application/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(myNotificationsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Bildirimler'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ref.read(markAllNotificationsReadProvider.notifier).markAll();
            },
            tooltip: 'Tümünü okundu işaretle',
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: notificationsAsync.when(
            data: (notifications) {
              if (notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        size: 80,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Henüz bildirim yok',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Yeni bildirimler burada görünecek',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: notifications.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(context, ref, notification);
                },
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
                    'Bildirimler yüklenemedi',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    WidgetRef ref,
    AppNotification notification,
  ) {
    final timeFormat = DateFormat('dd MMM, HH:mm', 'tr_TR');
    final timestamp = timeFormat.format(notification.createdAt.toLocal());

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        decoration: const BoxDecoration(
          color: AppColors.danger,
          borderRadius: AppRadii.brMd,
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        ref.read(deleteNotificationProvider.notifier).delete(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bildirim silindi', style: GoogleFonts.inter()),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          if (!notification.isRead) {
            ref
                .read(markNotificationReadProvider.notifier)
                .mark(notification.id);
          }
        },
        child: GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _getNotificationColor(
                    notification.type,
                  ).withValues(alpha: 0.2),
                  borderRadius: AppRadii.brMd,
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getNotificationTitle(notification.type),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      notification.message,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      timestamp,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.invite:
        return Icons.mail_outline;
      case NotificationType.application:
        return Icons.person_add_outlined;
      case NotificationType.rating:
        return Icons.star_outline;
      case NotificationType.system:
        return Icons.info_outline;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.invite:
        return AppColors.primary;
      case NotificationType.application:
        return AppColors.accentCyan;
      case NotificationType.rating:
        return AppColors.warning;
      case NotificationType.system:
        return AppColors.info;
    }
  }

  String _getNotificationTitle(NotificationType type) {
    switch (type) {
      case NotificationType.invite:
        return 'Davet';
      case NotificationType.application:
        return 'Başvuru';
      case NotificationType.rating:
        return 'Değerlendirme';
      case NotificationType.system:
        return 'Sistem';
    }
  }
}
