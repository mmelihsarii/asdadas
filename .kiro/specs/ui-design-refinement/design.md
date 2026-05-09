# UI Design Refinement Bugfix Design

## Overview

This bugfix addresses systematic UI/UX design issues in the Flutter mobile application that create a "template-like" and "cheap" visual impression. The core problems stem from excessive glassmorphism usage (40-50+ surfaces), oversized component scaling (padding, typography, avatars), weak visual hierarchy, and performance degradation from heavy GPU rendering.

The fix implements a strategic three-tier glassmorphism hierarchy (Premium/Subtle/Minimal), reduces component dimensions by 20%, introduces a new SolidCard widget for list items, and optimizes performance by reducing BackdropFilter usage by 60-70%. All existing functionality, architecture, navigation flows, and design system consistency are preserved.

## Glossary

- **Bug_Condition (C)**: The condition that triggers the bug - when UI elements exhibit excessive glassmorphism, oversized scaling, weak hierarchy, or performance issues
- **Property (P)**: The desired behavior - strategic glassmorphism usage (15-20 surfaces), refined component scaling (20% reduction), three-tier visual hierarchy, and optimized performance
- **Preservation**: All existing functionality, architecture, navigation flows, state management, data handling, and design system consistency that must remain unchanged
- **GlassContainer**: Widget in `lib/core/widgets/glass_container.dart` that applies BackdropFilter blur for glassmorphism effect (GPU-intensive)
- **GlassCard**: Widget in `lib/core/widgets/glass_card.dart` that uses GlassSurface (no blur) for list items
- **GlassSurface**: Widget in `lib/core/widgets/glass_surface.dart` that creates glass illusion without BackdropFilter (performance-optimized)
- **SolidCard**: New widget to be created in `lib/core/widgets/solid_card.dart` for list items with solid backgrounds and subtle borders
- **GlassIntensity**: Enum in `lib/core/theme/glass_tokens.dart` defining blur levels: subtle (2.55 sigma), regular (4.25 sigma), strong (6.8 sigma)
- **AppSpacing**: Token class in `lib/core/theme/app_spacing.dart` defining spacing scale (xxs: 2, xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 24, xxxl: 32, huge: 48)
- **Three-Tier Hierarchy**: Visual system with Premium (full glassmorphism for navigation/overlays), Subtle (minimal glassmorphism for primary content), Minimal (solid backgrounds for secondary content)

## Bug Details

### Bug Condition

The bug manifests when UI elements are rendered with excessive glassmorphism, oversized dimensions, weak visual hierarchy, or performance-degrading rendering patterns. The system is either applying glassmorphism indiscriminately to all surfaces (40-50+ BackdropFilter instances), using oversized spacing/typography/avatar dimensions, failing to differentiate visual importance through hierarchy, or performing redundant GPU calculations.

**Formal Specification:**
```
FUNCTION isBugCondition(input)
  INPUT: input of type UIElement
  OUTPUT: boolean
  
  RETURN (input.usesGlassmorphism AND input.isListItem)
         OR (input.usesGlassmorphism AND input.isSmallElement)
         OR (input.padding >= AppSpacing.lg AND NOT input.isReducedPadding)
         OR (input.avatarRadius >= 30 AND NOT input.isReducedSize)
         OR (input.fontSize >= 16 AND input.isBodyText AND NOT input.isReducedSize)
         OR (input.spacing >= AppSpacing.md AND NOT input.isReducedSpacing)
         OR (input.hasGlassmorphism AND input.visualTier == "secondary")
         OR (input.borderRadius >= 12 AND NOT input.isReducedRadius)
         OR (input.screenGlassSurfaceCount > 20)
END FUNCTION
```

### Examples

**Example 1: Messages List Screen - Excessive Glassmorphism on List Items**
- **Current Behavior**: Each message conversation card uses `GlassCard` which wraps `GlassSurface` (no blur but glass styling). While not using BackdropFilter, the visual treatment is still too heavy for list items.
- **Expected Behavior**: Message conversation cards should use `SolidCard` with solid background (`AppColors.surface`), subtle border, and reduced padding (12.8px instead of 16px).
- **File**: `lib/features/messages/presentation/messages_list_screen.dart`

**Example 2: Profile Screen - Oversized Avatar and Padding**
- **Current Behavior**: Profile avatar uses `GradientAvatarRing(size: 100)` with `GlassCard` padding of `AppSpacing.lg` (16px).
- **Expected Behavior**: Avatar should be reduced to `size: 80` (20% reduction) and card padding should be `12.8px` (20% reduction of 16px).
- **File**: `lib/features/profile/presentation/profile_screen.dart`

**Example 3: Explore Screen - Excessive GlassContainer Usage**
- **Current Behavior**: View mode toggle uses `GlassContainer`, filter button uses `GlassContainer`, filters panel uses `GlassCard`, listing cards use `GlassCard`, modal sheets use `GlassCard` (5+ glass surfaces on one screen).
- **Expected Behavior**: View mode toggle should use solid background container, listing cards in list view should use `SolidCard`, filters panel should use `GlassCard(intensity: subtle)`, modal sheets should keep `GlassContainer(intensity: regular)` (overlays are Tier 1).
- **File**: `lib/features/explore/presentation/explore_screen.dart`

**Example 4: Profile Screen Settings Card - Weak Visual Hierarchy**
- **Current Behavior**: Settings card uses `GlassCard` with same visual weight as profile card and stats card, making all sections compete for attention.
- **Expected Behavior**: Settings card should use `GlassCard(intensity: subtle)` or `SolidCard` to differentiate it as secondary content, while profile card maintains `GlassCard(intensity: regular)` as primary content.
- **File**: `lib/features/profile/presentation/profile_screen.dart`

**Edge Case: Modal Dialogs and Bottom Sheets**
- **Expected Behavior**: Modal dialogs and bottom sheets should ALWAYS maintain `GlassContainer(intensity: regular)` or `GlassCard(intensity: regular)` because they are overlays (Tier 1 - Premium Glassmorphism). This is correct usage and should be preserved.

## Expected Behavior

### Preservation Requirements

**Unchanged Behaviors:**
- All navigation flows, routing, and screen transitions must continue to work exactly as before
- All form validation logic, state management (Riverpod providers), and data handling must remain unchanged
- All authentication/authorization mechanisms and user session management must be preserved
- All repository patterns, API integrations, and data layer architecture must remain unchanged
- All feature functionality (explore, profile, messaging, match/player listings) must continue to work identically
- All design system tokens (AppColors, gradients, font families, font weights) must remain unchanged
- All interactive behaviors (hover states, tap feedback, animations) must be preserved
- All accessibility features (semantic labels, contrast ratios, screen reader support) must remain unchanged
- All gradient buttons, gradient avatar rings, error/loading states must continue to display with existing styling
- All modal sheets and dialogs must continue to display overlays with existing dismiss behaviors

**Scope:**
All inputs that do NOT involve visual refinement (glassmorphism reduction, dimension scaling, hierarchy implementation) should be completely unaffected by this fix. This includes:
- User interactions (taps, swipes, gestures)
- Data fetching and state updates
- Navigation and routing logic
- Form submissions and validation
- Authentication flows
- Real-time updates (messages, notifications)

## Hypothesized Root Cause

Based on the bug description and codebase analysis, the most likely issues are:

1. **Indiscriminate Glassmorphism Application**: The codebase uses `GlassCard` and `GlassContainer` without strategic differentiation. List items, form sections, and small UI elements all receive glass treatment, creating visual fatigue and performance overhead.
   - `messages_list_screen.dart` uses `GlassCard` for every conversation item
   - `profile_screen.dart` uses `GlassCard` for all sections (profile, stats, settings) without hierarchy
   - `explore_screen.dart` uses `GlassContainer` for view toggle, filter button, and multiple cards

2. **Oversized Spacing Token Usage**: The codebase consistently uses `AppSpacing.lg` (16px), `AppSpacing.xl` (20px), and `AppSpacing.xxl` (24px) for padding and spacing, creating bloated layouts.
   - Default `GlassCard` padding is `AppSpacing.lg` (16px)
   - Avatar sizes are 60-100px radius
   - Typography uses large font sizes (display: 32px, headline: 22-28px, body: 16px)

3. **Lack of Visual Hierarchy System**: The codebase does not differentiate between primary, secondary, and tertiary content through visual treatment. All cards receive the same glass intensity.
   - No usage of `GlassIntensity.subtle` for secondary content
   - No solid background alternative for list items
   - All sections compete for visual attention equally

4. **Missing Performance-Optimized List Widget**: The codebase lacks a lightweight alternative to `GlassCard` for list items. While `GlassCard` uses `GlassSurface` (no BackdropFilter), it still applies glass styling that is visually heavy for lists.
   - No `SolidCard` widget exists for list items
   - List screens use the same card styling as detail screens

## Correctness Properties

Property 1: Bug Condition - Strategic Glassmorphism and Refined Scaling

_For any_ UI element where the bug condition holds (isBugCondition returns true), the fixed rendering system SHALL apply strategic glassmorphism following the three-tier hierarchy (Premium: navigation/overlays with regular/strong intensity, Subtle: primary content with subtle intensity, Minimal: secondary content with solid backgrounds), reduce component dimensions by 20% (padding, avatars, typography, spacing), implement visual hierarchy through differentiated treatments, and optimize performance by reducing BackdropFilter usage to 15-20 surfaces (60-70% reduction from 40-50+ surfaces).

**Validates: Requirements 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11, 2.12, 2.13, 2.14, 2.15**

Property 2: Preservation - Functionality and Architecture

_For any_ functionality that is NOT related to visual refinement (navigation, state management, data handling, authentication, feature logic, design system tokens, interactive behaviors, accessibility), the fixed code SHALL produce exactly the same behavior as the original code, preserving all existing functionality, architecture, routing, validation, API integrations, gradient styling, modal behaviors, and user interactions.

**Validates: Requirements 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 3.13, 3.14, 3.15, 3.16**

## Fix Implementation

### Changes Required

Assuming our root cause analysis is correct:

**Phase 1: Create New Widgets and Update Existing Widgets**

**File**: `lib/core/widgets/solid_card.dart` (NEW)

**Purpose**: Create a lightweight card widget for list items with solid backgrounds

**Specific Changes**:
1. **Create SolidCard Widget**: Implement a new widget with solid background (`AppColors.surface`), subtle border (`AppColors.glassBorderSoft`), reduced default padding (12.8px = AppSpacing.lg * 0.8), optional `onTap` for interactivity, and `BorderRadius` parameter (default: `AppRadii.brMd`)

2. **Implementation Details**:
   - Use `Container` with `BoxDecoration` (no BackdropFilter)
   - Background color: `AppColors.surface`
   - Border: `Border.all(color: AppColors.glassBorderSoft, width: 1)`
   - Default padding: `EdgeInsets.all(12.8)` (20% reduction from 16px)
   - Wrap with `InkWell` if `onTap` is provided for tap feedback

**File**: `lib/core/widgets/glass_card.dart` (MODIFY)

**Purpose**: Add intensity parameter to support three-tier hierarchy

**Specific Changes**:
1. **Add Intensity Parameter**: Add `GlassIntensity intensity` parameter (default: `GlassIntensity.regular`)
2. **Pass Intensity to GlassSurface**: Modify `GlassSurface` to accept and use intensity parameter for tint and border color selection
3. **Update Default Padding**: Change default padding from `AppSpacing.lg` (16px) to `12.8` (20% reduction)

**File**: `lib/core/widgets/glass_surface.dart` (MODIFY)

**Purpose**: Support intensity-based styling

**Specific Changes**:
1. **Add Intensity Parameter**: Add `GlassIntensity intensity` parameter (default: `GlassIntensity.regular`)
2. **Use GlassTokens for Styling**: Use `GlassTokens.tint(intensity)` and `GlassTokens.border(intensity)` instead of hardcoded colors
3. **Update Default Padding**: Change default padding from `AppSpacing.md` (12px) to `9.6` (20% reduction)

**File**: `lib/core/widgets/glass_container.dart` (MODIFY)

**Purpose**: Ensure consistent intensity-based styling

**Specific Changes**:
1. **Update Default Padding**: Change default padding from `AppSpacing.lg` (16px) to `12.8` (20% reduction)
2. **Verify Intensity Usage**: Ensure intensity parameter is properly used for blur sigma, tint, and border selection

**Phase 2: Update List Screens (Tier 3 - Minimal Glassmorphism)**

**File**: `lib/features/messages/presentation/messages_list_screen.dart`

**Function**: `_buildConversationCard`

**Specific Changes**:
1. **Replace GlassCard with SolidCard**: Change `GlassCard` to `SolidCard` for conversation cards
2. **Reduce Avatar Size**: Change `GradientAvatarRing(size: 60)` to `size: 48` (20% reduction)
3. **Reduce Spacing**: Change `SizedBox(width: AppSpacing.md)` to `width: 9.6` (20% reduction from 12px)
4. **Reduce Padding**: Verify `SolidCard` uses default padding of 12.8px

**File**: `lib/features/my_matches/presentation/my_matches_screen.dart`

**Specific Changes**:
1. **Replace GlassCard with SolidCard**: Change match cards from `GlassCard` to `SolidCard`
2. **Replace GlassContainer with Solid Container**: Change filter tabs from `GlassContainer` to `Container` with solid background
3. **Reduce Padding and Spacing**: Apply 20% reduction to all padding and spacing values

**File**: `lib/features/offers/presentation/offers_screen.dart`

**Specific Changes**:
1. **Replace GlassCard with SolidCard**: Change offer cards from `GlassCard` to `SolidCard`
2. **Reduce Padding and Spacing**: Apply 20% reduction to all padding and spacing values

**Phase 3: Update Detail Screens (Tier 2 - Subtle Glassmorphism)**

**File**: `lib/features/profile/presentation/profile_screen.dart`

**Function**: `_buildProfileCard`, `_buildStatsCard`, `_buildSettingsCard`

**Specific Changes**:
1. **Implement Visual Hierarchy**:
   - Profile card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
   - Stats card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
   - Settings card: Change to `SolidCard` or `GlassCard(intensity: GlassIntensity.subtle)` (tertiary content)

2. **Reduce Avatar Size**: Change `GradientAvatarRing(size: 100)` to `size: 80` (20% reduction)

3. **Reduce Padding and Spacing**: Apply 20% reduction:
   - `AppSpacing.lg` (16px) → 12.8px
   - `AppSpacing.md` (12px) → 9.6px
   - `AppSpacing.sm` (8px) → 6.4px
   - `AppSpacing.xs` (4px) → 3.2px

4. **Reduce Icon Sizes**: Change icon sizes from 20-24px to 16-19.2px (20% reduction)

5. **Reduce Typography**: Apply 20% reduction to font sizes:
   - Header (28px) → 22.4px
   - Card title (24px) → 19.2px
   - Body text (16px) → 12.8px
   - Label text (14px) → 11.2px
   - Small text (11-12px) → 8.8-9.6px

**File**: `lib/features/profile/presentation/user_profile_screen.dart`

**Specific Changes**:
1. **Implement Visual Hierarchy**:
   - Stats card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
   - Info card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
   - Reviews/matches card: Change to `SolidCard` (tertiary content)

2. **Reduce Dimensions**: Apply 20% reduction to avatars, padding, spacing, icons, and typography

**File**: `lib/features/match_listings/presentation/match_listing_detail_screen.dart`

**Specific Changes**:
1. **Implement Visual Hierarchy**:
   - Main info card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
   - Organizer card, players card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
   - Description card, location card: Change to `SolidCard` (tertiary content)
   - Join confirmation dialog: Keep `GlassContainer(intensity: GlassIntensity.regular)` (overlay - Tier 1)

2. **Reduce Dimensions**: Apply 20% reduction to all padding, spacing, icons, and typography

**Phase 4: Update Form Screens (Tier 2 - Subtle Glassmorphism)**

**File**: `lib/features/match_listings/presentation/match_listing_create_screen.dart`

**Specific Changes**:
1. **Replace Section GlassCards with SolidCard**: Change form section containers from `GlassCard` to `SolidCard` or remove containers and use section headers only
2. **Group Form Fields**: Combine related fields into single containers instead of individual cards per field
3. **Reduce Dimensions**: Apply 20% reduction to all padding, spacing, and typography

**File**: `lib/features/player_listings/presentation/player_listing_create_screen.dart`

**Specific Changes**:
1. **Replace Section GlassCards with SolidCard**: Change form section containers from `GlassCard` to `SolidCard`
2. **Group Form Fields**: Combine related fields into single containers
3. **Reduce Dimensions**: Apply 20% reduction to all padding, spacing, and typography

**Phase 5: Update Explore Screen (Tier 2 - Subtle Glassmorphism)**

**File**: `lib/features/explore/presentation/explore_screen.dart`

**Function**: `_buildTopControls`, `_buildFilters`, `_buildListingCard`, `_showListingDetail`, `_showCreateOptions`

**Specific Changes**:
1. **Replace View Mode Toggle GlassContainer**: Change view mode toggle from `GlassContainer` to `Container` with solid background (`AppColors.surface`) and subtle border

2. **Keep Filter Button GlassContainer**: Maintain `GlassContainer` for filter button (small element, acceptable usage)

3. **Update Filters Panel**: Change filters panel to `GlassCard(intensity: GlassIntensity.subtle)`

4. **Replace Listing Cards in List View**: Change listing cards from `GlassCard` to `SolidCard` in list view

5. **Keep Modal Sheets**: Maintain `GlassCard(intensity: GlassIntensity.regular)` for modal bottom sheets (overlays - Tier 1)

6. **Reduce Dimensions**: Apply 20% reduction:
   - Icon sizes (24-28px) → 19.2-22.4px
   - Avatar/icon container sizes (60px) → 48px
   - Padding and spacing throughout
   - Typography sizes

7. **Reduce Shadow Blur**: Change `BoxShadow` blur radius from 12-20px to 7.2-12px (40% reduction for visual refinement)

**Phase 6: Update Core Widgets (Tier 1 - Premium Glassmorphism - Preserve)**

**File**: `lib/core/widgets/glass_app_bar.dart`

**Specific Changes**:
1. **Preserve Glassmorphism**: Keep `GlassContainer(intensity: GlassIntensity.regular)` (navigation - Tier 1)
2. **Reduce Padding**: Apply 20% reduction to internal padding only

**File**: `lib/core/widgets/glass_bottom_nav.dart`

**Specific Changes**:
1. **Preserve Glassmorphism**: Keep `GlassContainer(intensity: GlassIntensity.regular)` (navigation - Tier 1)
2. **Reduce Padding**: Apply 20% reduction to internal padding only

**File**: `lib/core/widgets/loading_state.dart`

**Specific Changes**:
1. **Evaluate Usage**: If used as overlay, keep `GlassContainer(intensity: GlassIntensity.regular)`. If used inline, change to `SolidCard` or `GlassCard(intensity: GlassIntensity.subtle)`
2. **Reduce Dimensions**: Apply 20% reduction to padding and spacing

**File**: `lib/core/widgets/error_state.dart`

**Specific Changes**:
1. **Evaluate Usage**: If used as overlay, keep `GlassContainer(intensity: GlassIntensity.regular)`. If used inline, change to `SolidCard` or `GlassCard(intensity: GlassIntensity.subtle)`
2. **Reduce Dimensions**: Apply 20% reduction to padding and spacing

**Phase 7: Update Border Radii (Optional Refinement)**

**File**: `lib/core/theme/app_radii.dart`

**Specific Changes**:
1. **Reduce Border Radii**: Apply 15-20% reduction to border radius values:
   - `brLg` (16px) → ~13px
   - `brMd` (12px) → ~10px
   - `brSm` (8px) → ~6.4px
2. **Note**: This is optional and should be evaluated after other changes are implemented

## Testing Strategy

### Validation Approach

The testing strategy follows a two-phase approach: first, surface counterexamples that demonstrate the bug on unfixed code (excessive glassmorphism, oversized dimensions, weak hierarchy, performance issues), then verify the fix works correctly (strategic glassmorphism, refined dimensions, clear hierarchy, optimized performance) and preserves existing behavior (functionality, architecture, navigation, design system).

### Exploratory Bug Condition Checking

**Goal**: Surface counterexamples that demonstrate the bug BEFORE implementing the fix. Confirm or refute the root cause analysis. If we refute, we will need to re-hypothesize.

**Test Plan**: Write tests that count glassmorphism usage, measure component dimensions, evaluate visual hierarchy, and measure rendering performance. Run these tests on the UNFIXED code to observe failures and understand the root cause.

**Test Cases**:
1. **Glassmorphism Count Test**: Count total `GlassContainer` and `GlassCard` instances across all screens (will show 40-50+ on unfixed code, expected: 15-20 after fix)
2. **List Item Glassmorphism Test**: Verify messages list, matches list, and offers list use `GlassCard` for every item (will fail on unfixed code - should use `SolidCard`)
3. **Dimension Measurement Test**: Measure avatar sizes, padding values, spacing values, typography sizes across screens (will show oversized values on unfixed code)
4. **Visual Hierarchy Test**: Verify profile screen uses same glass intensity for all cards (will fail on unfixed code - should differentiate primary/secondary/tertiary)
5. **Performance Test**: Measure frame rate during scroll on messages list with 20+ items (will show degraded performance on unfixed code due to heavy glass styling)

**Expected Counterexamples**:
- Glassmorphism count exceeds 40 surfaces across application
- List items use `GlassCard` instead of lightweight alternatives
- Avatar sizes are 60-100px (should be 48-80px)
- Padding values are 16-24px (should be 12.8-19.2px)
- All cards use same visual treatment regardless of content importance
- Scroll performance shows frame drops on list screens

### Fix Checking

**Goal**: Verify that for all inputs where the bug condition holds, the fixed rendering system produces the expected behavior.

**Pseudocode:**
```
FOR ALL uiElement WHERE isBugCondition(uiElement) DO
  result := renderElement_fixed(uiElement)
  ASSERT expectedBehavior(result)
END FOR
```

**Expected Behavior Verification:**
```
FUNCTION expectedBehavior(result)
  INPUT: result of type RenderedElement
  OUTPUT: boolean
  
  RETURN (result.glassmorphismCount <= 20)
         AND (result.listItemsUseSolidCard == true)
         AND (result.paddingReduction == 0.8)
         AND (result.avatarSizeReduction == 0.8)
         AND (result.typographyReduction == 0.8)
         AND (result.spacingReduction == 0.8)
         AND (result.hasVisualHierarchy == true)
         AND (result.tierSystemImplemented == true)
         AND (result.performanceOptimized == true)
END FUNCTION
```

### Preservation Checking

**Goal**: Verify that for all inputs where the bug condition does NOT hold (functionality, architecture, navigation, state management, design system tokens), the fixed code produces the same result as the original code.

**Pseudocode:**
```
FOR ALL functionality WHERE NOT isBugCondition(functionality) DO
  ASSERT originalBehavior(functionality) = fixedBehavior(functionality)
END FOR
```

**Testing Approach**: Property-based testing is recommended for preservation checking because:
- It generates many test cases automatically across the input domain
- It catches edge cases that manual unit tests might miss
- It provides strong guarantees that behavior is unchanged for all non-visual-refinement functionality

**Test Plan**: Observe behavior on UNFIXED code first for navigation, state management, data handling, and interactions, then write property-based tests capturing that behavior.

**Test Cases**:
1. **Navigation Preservation**: Verify all navigation flows (explore → detail, profile → edit, messages → chat) continue to work identically
2. **State Management Preservation**: Verify all Riverpod providers, state updates, and data fetching continue to work identically
3. **Form Validation Preservation**: Verify all form validation logic, error messages, and submission flows continue to work identically
4. **Authentication Preservation**: Verify login, logout, session management continue to work identically
5. **Design System Token Preservation**: Verify all `AppColors`, gradients, font families, font weights remain unchanged
6. **Interactive Behavior Preservation**: Verify tap feedback, hover states, animations continue to work identically
7. **Accessibility Preservation**: Verify semantic labels, contrast ratios, screen reader support remain unchanged
8. **Modal Behavior Preservation**: Verify modal sheets, dialogs, dismiss behaviors continue to work identically

### Unit Tests

- Test `SolidCard` widget renders with correct background color, border, and padding
- Test `GlassCard` with intensity parameter renders with correct tint and border colors
- Test dimension reduction calculations (20% reduction formula)
- Test visual hierarchy implementation (Tier 1/2/3 classification)
- Test glassmorphism count across screens (target: 15-20 surfaces)

### Property-Based Tests

- Generate random UI element configurations and verify strategic glassmorphism application (list items → SolidCard, overlays → GlassContainer)
- Generate random dimension values and verify 20% reduction is applied correctly
- Generate random screen compositions and verify visual hierarchy is maintained (primary/secondary/tertiary differentiation)
- Test that all non-visual functionality continues to work across many scenarios (navigation, state, validation, auth)

### Integration Tests

- Test full user flow with refined UI (explore → filter → view detail → join match)
- Test navigation between screens with refined dimensions and glassmorphism
- Test scroll performance on list screens with `SolidCard` (should show improved frame rates)
- Test visual hierarchy across multiple screens (profile, explore, messages)
- Test that modal overlays maintain glassmorphism (dialogs, bottom sheets)

### Visual Regression Tests

- Capture screenshots of key screens before and after fix
- Verify glassmorphism reduction is visible (fewer glass surfaces)
- Verify dimension reduction is visible (more compact layouts)
- Verify visual hierarchy is visible (differentiated card treatments)
- Verify design system consistency is maintained (colors, gradients, fonts unchanged)

### Performance Tests

- Measure frame rate during scroll on messages list (before: potential drops, after: stable 60fps)
- Measure GPU usage during screen rendering (before: high due to BackdropFilter, after: reduced)
- Measure widget rebuild counts (should remain unchanged - preservation)
- Measure memory usage (should remain similar or slightly reduced)
