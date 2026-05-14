import 'package:flutter/material.dart';
import 'app_exception.dart';

/// Centralized error handler for the app
class ErrorHandler {
  ErrorHandler._();

  /// Convert any error to AppException
  static AppException handleError(dynamic error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      return error;
    }

    // Network errors
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return NetworkException.noConnection();
    }

    if (error.toString().contains('TimeoutException')) {
      return NetworkException.timeout();
    }

    // Auth errors
    final errorStr = error.toString().toLowerCase();
    if (errorStr.contains('auth') ||
        errorStr.contains('login') ||
        errorStr.contains('credential')) {
      if (errorStr.contains('invalid') || errorStr.contains('wrong')) {
        return AuthException.invalidCredentials();
      }
      if (errorStr.contains('not found')) {
        return AuthException.userNotFound();
      }
      if (errorStr.contains('already') || errorStr.contains('exists')) {
        return AuthException.emailAlreadyInUse();
      }
    }

    // Database errors
    if (errorStr.contains('duplicate') || errorStr.contains('unique')) {
      return const RepositoryException(
        message: 'Bu kayıt zaten mevcut.',
        code: 'DUPLICATE',
      );
    }

    if (errorStr.contains('not found') || errorStr.contains('404')) {
      return RepositoryException.notFound('Kayıt');
    }

    // Storage errors
    if (errorStr.contains('upload')) {
      return StorageException.uploadFailed();
    }

    if (errorStr.contains('download')) {
      return StorageException.downloadFailed();
    }

    // Unknown error
    return UnknownException.fromError(error, stackTrace);
  }

  /// Show error message to user
  static void showErrorSnackBar(BuildContext context, AppException error) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Kapat',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show error dialog to user
  static Future<void> showErrorDialog(
    BuildContext context,
    AppException error,
  ) async {
    if (!context.mounted) return;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hata'),
        content: Text(error.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  /// Log error (can be extended to send to crash reporting service)
  static void logError(
    AppException error, {
    String? context,
    Map<String, dynamic>? additionalData,
  }) {
    // TODO: Send to crash reporting service (Sentry, Firebase Crashlytics, etc.)
    debugPrint('=== ERROR ===');
    debugPrint('Context: $context');
    debugPrint('Message: ${error.message}');
    debugPrint('Code: ${error.code}');
    if (error.originalError != null) {
      debugPrint('Original Error: ${error.originalError}');
    }
    if (error.stackTrace != null) {
      debugPrint('Stack Trace: ${error.stackTrace}');
    }
    if (additionalData != null) {
      debugPrint('Additional Data: $additionalData');
    }
    debugPrint('=============');
  }
}
