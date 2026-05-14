/// Base exception class for the app
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'İnternet bağlantısı yok. Lütfen bağlantınızı kontrol edin.',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.',
      code: 'TIMEOUT',
    );
  }

  factory NetworkException.serverError() {
    return const NetworkException(
      message: 'Sunucu hatası. Lütfen daha sonra tekrar deneyin.',
      code: 'SERVER_ERROR',
    );
  }
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory AuthException.invalidCredentials() {
    return const AuthException(
      message: 'Geçersiz kullanıcı adı veya şifre.',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthException.userNotFound() {
    return const AuthException(
      message: 'Kullanıcı bulunamadı.',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthException.emailAlreadyInUse() {
    return const AuthException(
      message: 'Bu e-posta adresi zaten kullanımda.',
      code: 'EMAIL_IN_USE',
    );
  }

  factory AuthException.weakPassword() {
    return const AuthException(
      message: 'Şifre çok zayıf. Lütfen daha güçlü bir şifre seçin.',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthException.sessionExpired() {
    return const AuthException(
      message: 'Oturumunuz sona erdi. Lütfen tekrar giriş yapın.',
      code: 'SESSION_EXPIRED',
    );
  }
}

/// Database/Repository-related exceptions
class RepositoryException extends AppException {
  const RepositoryException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory RepositoryException.notFound(String resource) {
    return RepositoryException(
      message: '$resource bulunamadı.',
      code: 'NOT_FOUND',
    );
  }

  factory RepositoryException.createFailed(String resource) {
    return RepositoryException(
      message: '$resource oluşturulamadı.',
      code: 'CREATE_FAILED',
    );
  }

  factory RepositoryException.updateFailed(String resource) {
    return RepositoryException(
      message: '$resource güncellenemedi.',
      code: 'UPDATE_FAILED',
    );
  }

  factory RepositoryException.deleteFailed(String resource) {
    return RepositoryException(
      message: '$resource silinemedi.',
      code: 'DELETE_FAILED',
    );
  }
}

/// Validation-related exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    this.fieldErrors,
    super.originalError,
    super.stackTrace,
  });

  factory ValidationException.invalidInput(String field) {
    return ValidationException(
      message: 'Geçersiz $field.',
      code: 'INVALID_INPUT',
      fieldErrors: {field: 'Geçersiz değer'},
    );
  }

  factory ValidationException.requiredField(String field) {
    return ValidationException(
      message: '$field zorunludur.',
      code: 'REQUIRED_FIELD',
      fieldErrors: {field: 'Bu alan zorunludur'},
    );
  }
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory PermissionException.denied(String permission) {
    return PermissionException(
      message: '$permission izni reddedildi.',
      code: 'PERMISSION_DENIED',
    );
  }

  factory PermissionException.notGranted(String permission) {
    return PermissionException(
      message: '$permission izni verilmedi. Lütfen ayarlardan izin verin.',
      code: 'PERMISSION_NOT_GRANTED',
    );
  }
}

/// Storage-related exceptions
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory StorageException.uploadFailed() {
    return const StorageException(
      message: 'Dosya yüklenemedi. Lütfen tekrar deneyin.',
      code: 'UPLOAD_FAILED',
    );
  }

  factory StorageException.downloadFailed() {
    return const StorageException(
      message: 'Dosya indirilemedi. Lütfen tekrar deneyin.',
      code: 'DOWNLOAD_FAILED',
    );
  }

  factory StorageException.fileTooLarge(int maxSizeMB) {
    return StorageException(
      message: 'Dosya çok büyük. Maksimum boyut: $maxSizeMB MB',
      code: 'FILE_TOO_LARGE',
    );
  }
}

/// Unknown/Unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory UnknownException.fromError(dynamic error, [StackTrace? stackTrace]) {
    return UnknownException(
      message: 'Beklenmeyen bir hata oluştu: ${error.toString()}',
      code: 'UNKNOWN',
      originalError: error,
      stackTrace: stackTrace,
    );
  }
}
