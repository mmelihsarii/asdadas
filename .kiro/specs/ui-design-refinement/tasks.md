# Implementation Plan

## Phase 0: Exploratory Testing (BEFORE Fix)

- [x] 1. Write bug condition exploration test
  - **Property 1: Bug Condition** - Excessive Glassmorphism and Oversized Dimensions
  - **CRITICAL**: This test MUST FAIL on unfixed code - failure confirms the bug exists
  - **DO NOT attempt to fix the test or the code when it fails**
  - **NOTE**: This test encodes the expected behavior - it will validate the fix when it passes after implementation
  - **GOAL**: Surface counterexamples that demonstrate the bug exists
  - **Test Implementation**:
    - Count total `GlassContainer` and `GlassCard` instances across all screens (expected: 40-50+ on unfixed code, target: 15-20 after fix)
    - Verify messages list uses `GlassCard` for every conversation item (should use `SolidCard`)
    - Verify explore screen uses `GlassContainer` for view mode toggle (should use solid container)
    - Measure avatar sizes: profile screen avatar (expected: 100px, target: 80px)
    - Measure padding values: `GlassCard` default padding (expected: 16px, target: 12.8px)
    - Verify profile screen uses same glass intensity for all cards (should differentiate primary/secondary/tertiary)
  - **EXPECTED OUTCOME**: Test FAILS (this is correct - it proves the bug exists)
  - Document counterexamples found to understand root cause
  - Mark task complete when test is written, run, and failure is documented
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 1.10, 1.11, 1.12_

- [x] 2. Write preservation property tests (BEFORE implementing fix)
  - **Property 2: Preservation** - Functionality and Architecture Preservation
  - **IMPORTANT**: Follow observation-first methodology
  - Observe behavior on UNFIXED code for non-visual-refinement functionality
  - Write property-based tests capturing observed behavior patterns from Preservation Requirements
  - **Test Implementation**:
    - Navigation flows: explore → detail, profile → edit, messages → chat
    - State management: Riverpod providers, state updates, data fetching
    - Form validation: validation logic, error messages, submission flows
    - Authentication: login, logout, session management
    - Design system tokens: `AppColors`, gradients, font families, font weights
    - Interactive behaviors: tap feedback, hover states, animations
    - Modal behaviors: modal sheets, dialogs, dismiss behaviors
  - Property-based testing generates many test cases for stronger guarantees
  - Run tests on UNFIXED code
  - **EXPECTED OUTCOME**: Tests PASS (this confirms baseline behavior to preserve)
  - Mark task complete when tests are written, run, and passing on unfixed code
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 3.13, 3.14, 3.15, 3.16_

## Phase 1: Create New Widgets and Update Existing Widgets

- [x] 3. Create SolidCard widget and update existing glass widgets

  - [x] 3.1 Create SolidCard widget
    - Create new file `lib/core/widgets/solid_card.dart`
    - Implement widget with solid background (`AppColors.surface`)
    - Add subtle border (`AppColors.glassBorderSoft`, width: 1)
    - Set default padding to 12.8px (20% reduction from 16px)
    - Add optional `onTap` parameter for interactivity
    - Add `BorderRadius` parameter (default: `AppRadii.brMd`)
    - Use `Container` with `BoxDecoration` (no BackdropFilter)
    - Wrap with `InkWell` if `onTap` is provided for tap feedback
    - _Bug_Condition: List items use GlassCard (heavy visual treatment)_
    - _Expected_Behavior: List items use SolidCard (lightweight solid background)_
    - _Preservation: Widget API follows existing card widget patterns_
    - _Requirements: 2.2, 2.5_

  - [x] 3.2 Update GlassCard widget
    - Add `GlassIntensity intensity` parameter (default: `GlassIntensity.regular`)
    - Pass intensity parameter to `GlassSurface`
    - Change default padding from `AppSpacing.lg` (16px) to `12.8` (20% reduction)
    - _Bug_Condition: GlassCard lacks intensity differentiation_
    - _Expected_Behavior: GlassCard supports three-tier hierarchy through intensity parameter_
    - _Preservation: Existing GlassCard usage without intensity parameter continues to work_
    - _Requirements: 2.1, 2.5, 2.9_

  - [x] 3.3 Update GlassSurface widget
    - Add `GlassIntensity intensity` parameter (default: `GlassIntensity.regular`)
    - Use `GlassTokens.tint(intensity)` for background tint
    - Use `GlassTokens.border(intensity)` for border color
    - Change default padding from `AppSpacing.md` (12px) to `9.6` (20% reduction)
    - _Bug_Condition: GlassSurface uses hardcoded colors_
    - _Expected_Behavior: GlassSurface uses intensity-based styling_
    - _Preservation: Existing GlassSurface usage continues to work_
    - _Requirements: 2.1, 2.5, 2.9_

  - [x] 3.4 Update GlassContainer widget
    - Change default padding from `AppSpacing.lg` (16px) to `12.8` (20% reduction)
    - Verify intensity parameter is properly used for blur sigma, tint, and border
    - _Bug_Condition: GlassContainer uses oversized padding_
    - _Expected_Behavior: GlassContainer uses refined padding (20% reduction)_
    - _Preservation: Existing GlassContainer usage continues to work_
    - _Requirements: 2.5_

## Phase 2: Update List Screens (Tier 3 - Minimal Glassmorphism)

- [x] 4. Update messages list screen

  - [x] 4.1 Replace GlassCard with SolidCard for conversation cards
    - In `lib/features/messages/presentation/messages_list_screen.dart`
    - Function: `_buildConversationCard`
    - Change `GlassCard` to `SolidCard`
    - _Bug_Condition: Conversation cards use GlassCard (heavy visual treatment)_
    - _Expected_Behavior: Conversation cards use SolidCard (lightweight solid background)_
    - _Preservation: Tap interactions and navigation continue to work_
    - _Requirements: 2.2, 2.10_

  - [x] 4.2 Reduce avatar size
    - Change `GradientAvatarRing(size: 60)` to `size: 48` (20% reduction)
    - _Bug_Condition: Avatar size is 60px (oversized)_
    - _Expected_Behavior: Avatar size is 48px (20% reduction)_
    - _Preservation: Avatar rendering and gradient ring continue to work_
    - _Requirements: 2.6_

  - [x] 4.3 Reduce spacing
    - Change `SizedBox(width: AppSpacing.md)` to `width: 9.6` (20% reduction from 12px)
    - Apply 20% reduction to all spacing values in the card
    - _Bug_Condition: Spacing uses AppSpacing.md (12px, oversized)_
    - _Expected_Behavior: Spacing uses 9.6px (20% reduction)_
    - _Preservation: Layout structure and alignment continue to work_
    - _Requirements: 2.8_

  - [x] 4.4 Reduce typography
    - Name text: 16px → 12.8px
    - Message text: 14px → 11.2px
    - Timestamp text: 11px → 8.8px
    - _Bug_Condition: Typography uses oversized font sizes_
    - _Expected_Behavior: Typography uses refined font sizes (20% reduction)_
    - _Preservation: Text rendering and font families continue to work_
    - _Requirements: 2.7_

- [x] 5. Update my matches screen

  - [x] 5.1 Replace GlassCard with SolidCard for match cards
    - In `lib/features/my_matches/presentation/my_matches_screen.dart`
    - Change match cards from `GlassCard` to `SolidCard`
    - _Bug_Condition: Match cards use GlassCard_
    - _Expected_Behavior: Match cards use SolidCard_
    - _Preservation: Match card interactions continue to work_
    - _Requirements: 2.2, 2.10_

  - [x] 5.2 Replace GlassContainer with solid Container for filter tabs
    - Change filter tabs from `GlassContainer` to `Container` with solid background
    - Use `AppColors.surface` for background
    - Add subtle border with `AppColors.glassBorderSoft`
    - _Bug_Condition: Filter tabs use GlassContainer (unnecessary glassmorphism)_
    - _Expected_Behavior: Filter tabs use solid container_
    - _Preservation: Filter tab interactions and state management continue to work_
    - _Requirements: 2.1, 2.4_

  - [x] 5.3 Reduce padding and spacing
    - Apply 20% reduction to all padding and spacing values
    - _Bug_Condition: Oversized padding and spacing_
    - _Expected_Behavior: Refined padding and spacing (20% reduction)_
    - _Preservation: Layout structure continues to work_
    - _Requirements: 2.5, 2.8_

- [x] 6. Update offers screen

  - [x] 6.1 Replace GlassCard with SolidCard for offer cards
    - In `lib/features/offers/presentation/offers_screen.dart`
    - Change offer cards from `GlassCard` to `SolidCard`
    - _Bug_Condition: Offer cards use GlassCard_
    - _Expected_Behavior: Offer cards use SolidCard_
    - _Preservation: Offer card interactions continue to work_
    - _Requirements: 2.2, 2.10_

  - [x] 6.2 Reduce padding and spacing
    - Apply 20% reduction to all padding and spacing values
    - _Bug_Condition: Oversized padding and spacing_
    - _Expected_Behavior: Refined padding and spacing (20% reduction)_
    - _Preservation: Layout structure continues to work_
    - _Requirements: 2.5, 2.8_

## Phase 3: Update Detail Screens (Tier 2 - Subtle Glassmorphism)

- [x] 7. Update profile screen

  - [x] 7.1 Implement visual hierarchy for cards
    - In `lib/features/profile/presentation/profile_screen.dart`
    - Profile card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
    - Stats card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
    - Settings card: Change to `SolidCard` (tertiary content)
    - _Bug_Condition: All cards use same visual treatment (no hierarchy)_
    - _Expected_Behavior: Cards differentiated by visual hierarchy (Tier 1/2/3)_
    - _Preservation: Card content and interactions continue to work_
    - _Requirements: 2.9, 2.11_

  - [x] 7.2 Reduce avatar size
    - Change `GradientAvatarRing(size: 100)` to `size: 80` (20% reduction)
    - _Bug_Condition: Avatar size is 100px (oversized)_
    - _Expected_Behavior: Avatar size is 80px (20% reduction)_
    - _Preservation: Avatar rendering continues to work_
    - _Requirements: 2.6_

  - [x] 7.3 Reduce padding and spacing
    - Apply 20% reduction:
      - `AppSpacing.lg` (16px) → 12.8px
      - `AppSpacing.md` (12px) → 9.6px
      - `AppSpacing.sm` (8px) → 6.4px
      - `AppSpacing.xs` (4px) → 3.2px
    - _Bug_Condition: Oversized padding and spacing_
    - _Expected_Behavior: Refined padding and spacing (20% reduction)_
    - _Preservation: Layout structure continues to work_
    - _Requirements: 2.5, 2.8_

  - [x] 7.4 Reduce icon sizes
    - Change icon sizes from 20-24px to 16-19.2px (20% reduction)
    - _Bug_Condition: Oversized icon dimensions_
    - _Expected_Behavior: Refined icon dimensions (20% reduction)_
    - _Preservation: Icon rendering continues to work_
    - _Requirements: 2.6_

  - [x] 7.5 Reduce typography
    - Apply 20% reduction to font sizes:
      - Header (28px) → 22.4px
      - Card title (24px) → 19.2px
      - Body text (16px) → 12.8px
      - Label text (14px) → 11.2px
      - Small text (11-12px) → 8.8-9.6px
    - _Bug_Condition: Oversized typography_
    - _Expected_Behavior: Refined typography (20% reduction)_
    - _Preservation: Text rendering and font families continue to work_
    - _Requirements: 2.7_

- [x] 8. Update user profile screen

  - [x] 8.1 Implement visual hierarchy for cards
    - In `lib/features/profile/presentation/user_profile_screen.dart`
    - Stats card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
    - Info card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
    - Reviews/matches card: Change to `SolidCard` (tertiary content)
    - _Bug_Condition: All cards use same visual treatment_
    - _Expected_Behavior: Cards differentiated by visual hierarchy_
    - _Preservation: Card content and interactions continue to work_
    - _Requirements: 2.9, 2.11_

  - [x] 8.2 Reduce dimensions
    - Apply 20% reduction to avatars, padding, spacing, icons, and typography
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Layout and rendering continue to work_
    - _Requirements: 2.5, 2.6, 2.7, 2.8_

- [x] 9. Update match listing detail screen

  - [x] 9.1 Implement visual hierarchy for cards
    - In `lib/features/match_listings/presentation/match_listing_detail_screen.dart`
    - Main info card: Keep `GlassCard(intensity: GlassIntensity.regular)` (primary content)
    - Organizer card, players card: Change to `GlassCard(intensity: GlassIntensity.subtle)` (secondary content)
    - Description card, location card: Change to `SolidCard` (tertiary content)
    - Join confirmation dialog: Keep `GlassContainer(intensity: GlassIntensity.regular)` (overlay - Tier 1)
    - _Bug_Condition: All cards use same visual treatment_
    - _Expected_Behavior: Cards differentiated by visual hierarchy_
    - _Preservation: Card content, interactions, and dialog behavior continue to work_
    - _Requirements: 2.9, 2.11_

  - [x] 9.2 Reduce dimensions
    - Apply 20% reduction to all padding, spacing, icons, and typography
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Layout and rendering continue to work_
    - _Requirements: 2.5, 2.6, 2.7, 2.8_

## Phase 4: Update Form Screens (Tier 2 - Subtle Glassmorphism)

- [x] 10. Update match listing create screen

  - [x] 10.1 Replace section GlassCards with SolidCard
    - In `lib/features/match_listings/presentation/match_listing_create_screen.dart`
    - Change form section containers from `GlassCard` to `SolidCard`
    - Alternative: Remove containers and use section headers only
    - _Bug_Condition: Every form section wrapped in GlassCard_
    - _Expected_Behavior: Form sections use SolidCard or section headers_
    - _Preservation: Form validation and submission continue to work_
    - _Requirements: 2.3, 2.10_

  - [x] 10.2 Group form fields
    - Combine related fields into single containers instead of individual cards per field
    - _Bug_Condition: Individual cards per field create visual bloat_
    - _Expected_Behavior: Related fields grouped in single containers_
    - _Preservation: Form field interactions continue to work_
    - _Requirements: 2.3_

  - [x] 10.3 Reduce dimensions
    - Apply 20% reduction to all padding, spacing, and typography
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Form layout continues to work_
    - _Requirements: 2.5, 2.7, 2.8_

- [x] 11. Update player listing create screen

  - [x] 11.1 Replace section GlassCards with SolidCard
    - In `lib/features/player_listings/presentation/player_listing_create_screen.dart`
    - Change form section containers from `GlassCard` to `SolidCard`
    - _Bug_Condition: Every form section wrapped in GlassCard_
    - _Expected_Behavior: Form sections use SolidCard_
    - _Preservation: Form validation and submission continue to work_
    - _Requirements: 2.3, 2.10_

  - [x] 11.2 Group form fields
    - Combine related fields into single containers
    - _Bug_Condition: Individual cards per field create visual bloat_
    - _Expected_Behavior: Related fields grouped in single containers_
    - _Preservation: Form field interactions continue to work_
    - _Requirements: 2.3_

  - [x] 11.3 Reduce dimensions
    - Apply 20% reduction to all padding, spacing, and typography
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Form layout continues to work_
    - _Requirements: 2.5, 2.7, 2.8_

## Phase 5: Update Explore Screen (Tier 2 - Subtle Glassmorphism)

- [x] 12. Update explore screen

  - [x] 12.1 Replace view mode toggle GlassContainer with solid Container
    - In `lib/features/explore/presentation/explore_screen.dart`
    - Function: `_buildTopControls`
    - Change view mode toggle from `GlassContainer` to `Container`
    - Use solid background (`AppColors.surface`)
    - Add subtle border (`AppColors.glassBorderSoft`)
    - _Bug_Condition: View mode toggle uses GlassContainer (unnecessary glassmorphism)_
    - _Expected_Behavior: View mode toggle uses solid container_
    - _Preservation: View mode toggle interactions continue to work_
    - _Requirements: 2.1, 2.4_

  - [x] 12.2 Keep filter button GlassContainer
    - Maintain `GlassContainer` for filter button (small element, acceptable usage)
    - _Bug_Condition: N/A (filter button is correctly using glassmorphism)_
    - _Expected_Behavior: Filter button maintains GlassContainer_
    - _Preservation: Filter button interactions continue to work_
    - _Requirements: 2.1_

  - [x] 12.3 Update filters panel
    - Function: `_buildFilters`
    - Change filters panel to `GlassCard(intensity: GlassIntensity.subtle)`
    - _Bug_Condition: Filters panel uses default intensity_
    - _Expected_Behavior: Filters panel uses subtle intensity_
    - _Preservation: Filter interactions continue to work_
    - _Requirements: 2.9_

  - [x] 12.4 Replace listing cards in list view with SolidCard
    - Function: `_buildListingCard`
    - Change listing cards from `GlassCard` to `SolidCard` in list view
    - _Bug_Condition: Listing cards use GlassCard_
    - _Expected_Behavior: Listing cards use SolidCard_
    - _Preservation: Listing card interactions continue to work_
    - _Requirements: 2.2, 2.10_

  - [x] 12.5 Keep modal sheets with GlassCard
    - Functions: `_showListingDetail`, `_showCreateOptions`
    - Maintain `GlassCard(intensity: GlassIntensity.regular)` for modal bottom sheets (overlays - Tier 1)
    - _Bug_Condition: N/A (modal sheets correctly use glassmorphism)_
    - _Expected_Behavior: Modal sheets maintain GlassCard_
    - _Preservation: Modal sheet behaviors continue to work_
    - _Requirements: 2.1_

  - [x] 12.6 Reduce dimensions
    - Apply 20% reduction:
      - Icon sizes (24-28px) → 19.2-22.4px
      - Avatar/icon container sizes (60px) → 48px
      - Padding and spacing throughout
      - Typography sizes
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Layout and rendering continue to work_
    - _Requirements: 2.5, 2.6, 2.7, 2.8_

  - [x] 12.7 Reduce shadow blur
    - Change `BoxShadow` blur radius from 12-20px to 7.2-12px (40% reduction)
    - _Bug_Condition: Oversized shadow blur_
    - _Expected_Behavior: Refined shadow blur (40% reduction)_
    - _Preservation: Shadow rendering continues to work_
    - _Requirements: 2.12_

## Phase 6: Update Core Widgets (Tier 1 - Premium Glassmorphism - Preserve)

- [x] 13. Update glass app bar

  - [x] 13.1 Preserve glassmorphism
    - In `lib/core/widgets/glass_app_bar.dart`
    - Keep `GlassContainer(intensity: GlassIntensity.regular)` (navigation - Tier 1)
    - _Bug_Condition: N/A (app bar correctly uses glassmorphism)_
    - _Expected_Behavior: App bar maintains glassmorphism_
    - _Preservation: App bar rendering and interactions continue to work_
    - _Requirements: 2.1_

  - [x] 13.2 Reduce internal padding
    - Apply 20% reduction to internal padding only
    - _Bug_Condition: Oversized internal padding_
    - _Expected_Behavior: Refined internal padding (20% reduction)_
    - _Preservation: App bar layout continues to work_
    - _Requirements: 2.5_

- [x] 14. Update glass bottom nav

  - [x] 14.1 Preserve glassmorphism
    - In `lib/core/widgets/glass_bottom_nav.dart`
    - Keep `GlassContainer(intensity: GlassIntensity.regular)` (navigation - Tier 1)
    - _Bug_Condition: N/A (bottom nav correctly uses glassmorphism)_
    - _Expected_Behavior: Bottom nav maintains glassmorphism_
    - _Preservation: Bottom nav rendering and interactions continue to work_
    - _Requirements: 2.1_

  - [x] 14.2 Reduce internal padding
    - Apply 20% reduction to internal padding only
    - _Bug_Condition: Oversized internal padding_
    - _Expected_Behavior: Refined internal padding (20% reduction)_
    - _Preservation: Bottom nav layout continues to work_
    - _Requirements: 2.5_

- [x] 15. Update loading state

  - [x] 15.1 Evaluate usage context
    - In `lib/core/widgets/loading_state.dart`
    - If used as overlay: Keep `GlassContainer(intensity: GlassIntensity.regular)`
    - If used inline: Change to `SolidCard` or `GlassCard(intensity: GlassIntensity.subtle)`
    - _Bug_Condition: Loading state may use inappropriate glassmorphism for context_
    - _Expected_Behavior: Loading state uses appropriate treatment based on context_
    - _Preservation: Loading state rendering continues to work_
    - _Requirements: 2.1, 2.9_

  - [x] 15.2 Reduce dimensions
    - Apply 20% reduction to padding and spacing
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Loading state layout continues to work_
    - _Requirements: 2.5, 2.8_

- [x] 16. Update error state

  - [x] 16.1 Evaluate usage context
    - In `lib/core/widgets/error_state.dart`
    - If used as overlay: Keep `GlassContainer(intensity: GlassIntensity.regular)`
    - If used inline: Change to `SolidCard` or `GlassCard(intensity: GlassIntensity.subtle)`
    - _Bug_Condition: Error state may use inappropriate glassmorphism for context_
    - _Expected_Behavior: Error state uses appropriate treatment based on context_
    - _Preservation: Error state rendering and retry mechanisms continue to work_
    - _Requirements: 2.1, 2.9_

  - [x] 16.2 Reduce dimensions
    - Apply 20% reduction to padding and spacing
    - _Bug_Condition: Oversized dimensions_
    - _Expected_Behavior: Refined dimensions (20% reduction)_
    - _Preservation: Error state layout continues to work_
    - _Requirements: 2.5, 2.8_

## Phase 7: Verification (AFTER Fix)

- [x] 17. Verify bug condition exploration test now passes

  - [x] 17.1 Re-run bug condition exploration test
    - **Property 1: Expected Behavior** - Strategic Glassmorphism and Refined Scaling
    - **IMPORTANT**: Re-run the SAME test from task 1 - do NOT write a new test
    - The test from task 1 encodes the expected behavior
    - When this test passes, it confirms the expected behavior is satisfied
    - Run bug condition exploration test from step 1
    - **EXPECTED OUTCOME**: Test PASSES (confirms bug is fixed)
    - Verify glassmorphism count is 15-20 surfaces (60-70% reduction)
    - Verify list items use `SolidCard`
    - Verify dimensions are reduced by 20%
    - Verify visual hierarchy is implemented
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11, 2.12, 2.13, 2.14, 2.15_

- [x] 18. Verify preservation tests still pass

  - [x] 18.1 Re-run preservation property tests
    - **Property 2: Preservation** - Functionality and Architecture Preservation
    - **IMPORTANT**: Re-run the SAME tests from task 2 - do NOT write new tests
    - Run preservation property tests from step 2
    - **EXPECTED OUTCOME**: Tests PASS (confirms no regressions)
    - Verify all navigation flows continue to work
    - Verify all state management continues to work
    - Verify all form validation continues to work
    - Verify all authentication continues to work
    - Verify all design system tokens remain unchanged
    - Verify all interactive behaviors continue to work
    - Verify all modal behaviors continue to work
    - Confirm all tests still pass after fix (no regressions)
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 3.13, 3.14, 3.15, 3.16_

## Phase 8: Optional Refinement

- [ ] 19. Update border radii (OPTIONAL)

  - [ ] 19.1 Reduce border radii
    - In `lib/core/theme/app_radii.dart`
    - Apply 15-20% reduction to border radius values:
      - `brLg` (16px) → ~13px
      - `brMd` (12px) → ~10px
      - `brSm` (8px) → ~6.4px
    - **NOTE**: This is optional and should be evaluated after other changes are implemented
    - _Bug_Condition: Oversized border radii contribute to template-like appearance_
    - _Expected_Behavior: Refined border radii for more mature appearance_
    - _Preservation: Border radius rendering continues to work_
    - _Requirements: 2.12_

- [x] 20. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise
  - Verify glassmorphism count is within target range (15-20 surfaces)
  - Verify visual hierarchy is clear and consistent
  - Verify performance improvements are measurable
  - Verify no regressions in functionality
