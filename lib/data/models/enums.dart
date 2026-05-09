// Enums for SAHADA app
// These match the PostgreSQL enums in the database

import 'package:json_annotation/json_annotation.dart';

/// Skill level of a player
enum SkillLevel {
  @JsonValue('BEGINNER')
  beginner,
  @JsonValue('INTERMEDIATE')
  intermediate,
  @JsonValue('ADVANCED')
  advanced,
}

/// Match format (number of players per side)
enum MatchFormat {
  @JsonValue('FIVE_VS_FIVE')
  fiveVsFive,
  @JsonValue('SIX_VS_SIX')
  sixVsSix,
  @JsonValue('SEVEN_VS_SEVEN')
  sevenVsSeven,
}

/// Player position on the field
enum PositionType {
  @JsonValue('GOALKEEPER')
  goalkeeper,
  @JsonValue('DEFENDER')
  defender,
  @JsonValue('MIDFIELDER')
  midfielder,
  @JsonValue('FORWARD')
  forward,
  @JsonValue('ANY')
  any,
}

/// Price type for matches
enum PriceType {
  @JsonValue('FREE')
  free,
  @JsonValue('PAID')
  paid,
}

/// Status of a listing (match or player)
enum ListingStatus {
  @JsonValue('OPEN')
  open,
  @JsonValue('FILLED')
  filled,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELED')
  canceled,
}

/// Status of an offer
enum OfferStatus {
  @JsonValue('SENT')
  sent,
  @JsonValue('COUNTERED')
  countered,
  @JsonValue('ACCEPTED')
  accepted,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('EXPIRED')
  expired,
}

/// Status of a participation in a match
enum ParticipationStatus {
  @JsonValue('ACCEPTED')
  accepted,
  @JsonValue('LEFT')
  left,
  @JsonValue('KICKED')
  kicked,
}

/// Status of a report
enum ReportStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('REVIEWED')
  reviewed,
  @JsonValue('RESOLVED')
  resolved,
}

/// Payment method
enum PaymentMethod {
  @JsonValue('CASH')
  cash,
  @JsonValue('IBAN')
  iban,
}

/// Cancellation policy level
enum CancellationLevel {
  @JsonValue('FLEXIBLE')
  flexible,
  @JsonValue('MEDIUM')
  medium,
  @JsonValue('STRICT')
  strict,
}

// Extension methods for display names (Turkish)
extension SkillLevelExtension on SkillLevel {
  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Başlangıç';
      case SkillLevel.intermediate:
        return 'Orta';
      case SkillLevel.advanced:
        return 'İleri';
    }
  }
}

extension MatchFormatExtension on MatchFormat {
  String get displayName {
    switch (this) {
      case MatchFormat.fiveVsFive:
        return '5v5';
      case MatchFormat.sixVsSix:
        return '6v6';
      case MatchFormat.sevenVsSeven:
        return '7v7';
    }
  }
}

extension PositionTypeExtension on PositionType {
  String get displayName {
    switch (this) {
      case PositionType.goalkeeper:
        return 'Kaleci';
      case PositionType.defender:
        return 'Defans';
      case PositionType.midfielder:
        return 'Orta Saha';
      case PositionType.forward:
        return 'Forvet';
      case PositionType.any:
        return 'Herhangi';
    }
  }
}

extension PriceTypeExtension on PriceType {
  String get displayName {
    switch (this) {
      case PriceType.free:
        return 'Ücretsiz';
      case PriceType.paid:
        return 'Ücretli';
    }
  }
}

extension ListingStatusExtension on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.open:
        return 'Açık';
      case ListingStatus.filled:
        return 'Dolu';
      case ListingStatus.completed:
        return 'Tamamlandı';
      case ListingStatus.canceled:
        return 'İptal Edildi';
    }
  }
}

extension OfferStatusExtension on OfferStatus {
  String get displayName {
    switch (this) {
      case OfferStatus.sent:
        return 'Gönderildi';
      case OfferStatus.countered:
        return 'Karşı Teklif';
      case OfferStatus.accepted:
        return 'Kabul Edildi';
      case OfferStatus.rejected:
        return 'Reddedildi';
      case OfferStatus.expired:
        return 'Süresi Doldu';
    }
  }
}

extension ParticipationStatusExtension on ParticipationStatus {
  String get displayName {
    switch (this) {
      case ParticipationStatus.accepted:
        return 'Katılıyor';
      case ParticipationStatus.left:
        return 'Ayrıldı';
      case ParticipationStatus.kicked:
        return 'Çıkarıldı';
    }
  }
}

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.pending:
        return 'Beklemede';
      case ReportStatus.reviewed:
        return 'İncelendi';
      case ReportStatus.resolved:
        return 'Çözüldü';
    }
  }
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Nakit';
      case PaymentMethod.iban:
        return 'IBAN';
    }
  }
}

extension CancellationLevelExtension on CancellationLevel {
  String get displayName {
    switch (this) {
      case CancellationLevel.flexible:
        return 'Esnek';
      case CancellationLevel.medium:
        return 'Orta';
      case CancellationLevel.strict:
        return 'Katı';
    }
  }
}
