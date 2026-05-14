/// App-wide dimension constants
/// These values are used consistently across the app for spacing, sizing, and layout
class AppDimensions {
  AppDimensions._(); // Private constructor to prevent instantiation

  // Font sizes (20% reduction applied from base sizes)
  static const double fontSizeXSmall = 8.8; // 11px * 0.8
  static const double fontSizeSmall = 9.6; // 12px * 0.8
  static const double fontSizeReduced = 11.2; // 14px * 0.8
  static const double fontSizeMedium = 12.8; // 16px * 0.8
  static const double fontSizeLarge = 14.4; // 18px * 0.8
  static const double fontSizeXLarge = 19.2; // 24px * 0.8
  static const double fontSizeXXLarge = 22.4; // 28px * 0.8

  // Spacing (20% reduction applied from base sizes)
  static const double spacingXSmall = 3.2; // 4px * 0.8
  static const double spacingSmall = 6.4; // 8px * 0.8
  static const double spacingMedium = 9.6; // 12px * 0.8
  static const double spacingLarge = 12.8; // 16px * 0.8
  static const double spacingXLarge = 16.0; // 20px * 0.8

  // Icon sizes
  static const double iconSizeSmall = 14.0;
  static const double iconSizeMedium = 16.0;
  static const double iconSizeLarge = 19.2; // 24px * 0.8
  static const double iconSizeXLarge = 32.0;
  static const double iconSizeXXLarge = 38.4; // 48px * 0.8
  static const double iconSizeHuge = 64.0;

  // Avatar sizes
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 80.0;
  static const double avatarSizeXLarge = 120.0;

  // Container sizes
  static const double containerPaddingSmall = 6.4;
  static const double containerPaddingMedium = 9.6;
  static const double containerPaddingLarge = 12.8;

  // Button sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightCompact = 40.0;
  static const double buttonIconSize = 16.0;

  // Bottom sheet
  static const double bottomSheetOffset = 90.0;
  static const double bottomSheetHandleWidth = 40.0;
  static const double bottomSheetHandleHeight = 4.0;

  // Divider
  static const double dividerHeight = 1.0;
  static const double dividerThickness = 1.0;

  // Border
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 3.0;

  // Elevation
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // Map
  static const double mapZoomDefault = 15.0;
  static const double mapZoomMin = 10.0;
  static const double mapZoomMax = 18.0;

  // List item
  static const double listItemHeight = 72.0;
  static const double listItemHeightCompact = 56.0;

  // Card
  static const double cardElevation = 2.0;
  static const double cardPadding = 12.8;

  // Input field
  static const double inputFieldHeight = 48.0;
  static const double inputFieldPadding = 12.0;

  // Chip
  static const double chipHeight = 32.0;
  static const double chipPaddingHorizontal = 12.0;
  static const double chipPaddingVertical = 8.0;

  // Badge
  static const double badgeSize = 8.0;
  static const double badgeSizeLarge = 12.0;

  // Progress indicator
  static const double progressIndicatorSize = 24.0;
  static const double progressIndicatorSizeLarge = 48.0;

  // Opacity
  static const double opacityDisabled = 0.5;
  static const double opacityHover = 0.8;
  static const double opacityPressed = 0.6;

  // Animation duration (milliseconds)
  static const int animationDurationFast = 150;
  static const int animationDurationNormal = 300;
  static const int animationDurationSlow = 500;
}
