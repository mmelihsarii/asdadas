# Implementation Plan

## Overview

This implementation plan follows the exploratory bugfix workflow using the bug condition methodology. The workflow consists of three phases:

1. **Exploration Phase (BEFORE Fix)**: Write tests that demonstrate the bug exists on unfixed code
2. **Implementation Phase**: Apply the fix with understanding gained from exploration
3. **Validation Phase (AFTER Fix)**: Verify the fix works and preserves existing behavior

---

## Phase 0: Exploratory Testing (BEFORE Fix)

### Task 1: Write Bug Condition Exploration Test

- [x] 1. Write bug condition exploration test
  - **Property 1: Bug Condition** - Button Proportional Dimensions
  - **CRITICAL**: This test MUST FAIL on unfixed code - failure confirms the bug exists
  - **DO NOT attempt to fix the test or the code when it fails**
  - **NOTE**: This test encodes the expected behavior - it will validate the fix when it passes after implementation
  - **GOAL**: Surface counterexamples that demonstrate buttons have excessive dimensions that dominate content
  - **Scoped PBT Approach**: Measure button dimensions across key screens (Offers, Match Detail, Profile, Dialogs) and verify they exceed proportional thresholds
  - Test implementation details from Bug Condition in design:
    - Measure GradientButton vertical padding (expect >= 16px on unfixed code)
    - Measure GradientButton horizontal padding (expect >= 20px on unfixed code)
    - Measure button font size (expect >= 16px on unfixed code)
    - Measure button icon size (expect >= 20px on unfixed code)
    - Measure button height (expect >= 48px on unfixed code)
    - Compare button visual weight to surrounding content weight (expect buttons dominate on unfixed code)
    - Verify lack of hierarchy differentiation when multiple actions present (expect equal visual weight on unfixed code)
  - The test assertions should match the Expected Behavior Properties from design:
    - Assert buttons should have reduced dimensions (12px vertical padding for primary, 10px for secondary)
    - Assert buttons should have compact horizontal padding (16px for primary, 12px for secondary)
    - Assert button text should be appropriately sized (14px for primary, 13px for secondary)
    - Assert button icons should be proportional (18px for primary, 16px for secondary)
    - Assert buttons should maintain 44x44 minimum touch target
    - Assert buttons should be visually subordinate to content headings
  - Run test on UNFIXED code
  - **EXPECTED OUTCOME**: Test FAILS (this is correct - it proves the bug exists)
  - Document counterexamples found:
    - Screenshot Offers screen showing oversized accept/reject buttons
    - Screenshot Match Detail screen showing inflated "Katıl" button in bottom bar
    - Screenshot Profile screen showing oversized "Çıkış Yap" button
    - Screenshot Dialog showing oversized confirmation buttons
    - Measure and record actual dimensions vs. expected dimensions
  - Mark task complete when test is written, run, and failure is documented
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.6, 1.7, 1.11, 1.14, 1.17, 1.18_

### Task 2: Write Preservation Property Tests

- [x] 2. Write preservation property tests (BEFORE implementing fix)
  - **Property 2: Preservation** - Button Functionality and Accessibility
  - **IMPORTANT**: Follow observation-first methodology
  - Observe behavior on UNFIXED code for non-buggy inputs (button functionality, touch targets, states, accessibility):
    - Observe: Button onPressed callbacks execute correctly
    - Observe: Disabled buttons show appropriate visual feedback and prevent interaction
    - Observe: Loading buttons show spinner and prevent interaction
    - Observe: Pressed buttons show AnimatedScale feedback (0.97 scale)
    - Observe: All buttons maintain minimum 44x44 touch target
    - Observe: Gradient styling and shadow effects render correctly
    - Observe: Navigation flows triggered by buttons work correctly
    - Observe: Semantic labels and accessibility properties are present
  - Write property-based tests capturing observed behavior patterns from Preservation Requirements:
    - Property: For all button types (GradientButton, GradientOutlinedButton), onPressed callbacks execute identically before and after fix
    - Property: For all button states (enabled, disabled, loading, pressed), visual feedback and interaction behavior is preserved
    - Property: For all button configurations (with/without icons, various label lengths), touch targets remain >= 44x44
    - Property: For all button contexts (cards, dialogs, bottom bars, forms), gradient styling and shadow effects are unchanged
    - Property: For all navigation flows triggered by buttons, routing logic is preserved
    - Property: For all accessibility properties (semantic labels, roles), values are unchanged
  - Property-based testing generates many test cases for stronger guarantees
  - Run tests on UNFIXED code
  - **EXPECTED OUTCOME**: Tests PASS (this confirms baseline behavior to preserve)
  - Mark task complete when tests are written, run, and passing on unfixed code
  - _Requirements: 3.1, 3.2, 3.3, 3.5, 3.6, 3.7, 3.11, 3.12, 3.13, 3.14_

---

## Phase 1: Core Button Widget Refinement

### Task 3: Refine GradientButton (Primary CTA)

- [x] 3. Refine GradientButton widget dimensions

  - [x] 3.1 Update GradientButton vertical padding
    - Change from `AppSpacing.lg` (16px) to `AppSpacing.md` (12px)
    - File: `lib/core/widgets/gradient_button.dart`
    - Line: `vertical: AppSpacing.lg,` → `vertical: AppSpacing.md,`
    - Rationale: Reduces button height from ~52px to ~44px while maintaining 44x44 touch target
    - _Bug_Condition: isBugCondition(input) where input.verticalPadding >= 16_
    - _Expected_Behavior: Button height ~44px with 12px vertical padding_
    - _Preservation: Touch target remains >= 44x44 (Requirement 3.5)_
    - _Requirements: 1.1, 2.1, 3.5_

  - [x] 3.2 Update GradientButton horizontal padding
    - Change from `AppSpacing.xl` (20px) to `AppSpacing.lg` (16px)
    - File: `lib/core/widgets/gradient_button.dart`
    - Line: `horizontal: AppSpacing.xl,` → `horizontal: AppSpacing.lg,`
    - Rationale: Creates more compact button width proportional to label length
    - _Bug_Condition: isBugCondition(input) where input.horizontalPadding >= 20_
    - _Expected_Behavior: Button width with 16px horizontal padding_
    - _Preservation: Button functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.2, 2.2, 3.1_

  - [x] 3.3 Update GradientButton font size
    - Change from 16px to 14px
    - File: `lib/core/widgets/gradient_button.dart`
    - Line: `fontSize: 16,` → `fontSize: 14,`
    - Rationale: Makes button text visually subordinate to headings and content
    - _Bug_Condition: isBugCondition(input) where input.fontSize >= 16_
    - _Expected_Behavior: Button text at 14px feels quieter than headings_
    - _Preservation: Text rendering and accessibility unchanged (Requirement 3.6)_
    - _Requirements: 1.3, 2.3, 2.18, 3.6_

  - [x] 3.4 Update GradientButton icon size
    - Change from 20px to 18px
    - File: `lib/core/widgets/gradient_button.dart`
    - Line: `size: 20,` → `size: 18,`
    - Rationale: Creates better proportional balance between icon and button dimensions
    - _Bug_Condition: isBugCondition(input) where input.iconSize >= 20_
    - _Expected_Behavior: Icon at 18px feels proportional to button_
    - _Preservation: Icon rendering and alignment unchanged (Requirement 3.13)_
    - _Requirements: 1.4, 2.4, 3.13_

  - [x] 3.5 Update GradientButton loading indicator size
    - Change from 20px to 18px
    - File: `lib/core/widgets/gradient_button.dart`
    - Line: `height: 20, width: 20,` → `height: 18, width: 18,`
    - Rationale: Maintains consistency with icon size
    - _Bug_Condition: isBugCondition(input) where input.iconSize >= 20_
    - _Expected_Behavior: Loading indicator at 18px matches icon size_
    - _Preservation: Loading state behavior unchanged (Requirement 3.7)_
    - _Requirements: 1.4, 2.4, 3.7_

### Task 4: Refine GradientOutlinedButton (Secondary)

- [x] 4. Refine GradientOutlinedButton widget dimensions

  - [x] 4.1 Update GradientOutlinedButton vertical padding
    - Change from `AppSpacing.lg` (16px) to 10px (custom value)
    - File: `lib/core/widgets/gradient_outlined_button.dart`
    - Line: `vertical: AppSpacing.lg,` → `vertical: 10,`
    - Rationale: Creates clear visual differentiation from primary buttons (secondary = less prominent)
    - _Bug_Condition: isBugCondition(input) where input.verticalPadding >= 16 AND input.hierarchyDifferentiation == false_
    - _Expected_Behavior: Secondary button height ~40px with 10px vertical padding_
    - _Preservation: Touch target remains >= 44x44 (Requirement 3.5)_
    - _Requirements: 1.1, 1.6, 2.1, 2.6, 3.5_

  - [x] 4.2 Update GradientOutlinedButton horizontal padding
    - Change from `AppSpacing.xl` (20px) to `AppSpacing.md` (12px)
    - File: `lib/core/widgets/gradient_outlined_button.dart`
    - Line: `horizontal: AppSpacing.xl,` → `horizontal: AppSpacing.md,`
    - Rationale: Creates more compact secondary button width
    - _Bug_Condition: isBugCondition(input) where input.horizontalPadding >= 20_
    - _Expected_Behavior: Secondary button width with 12px horizontal padding_
    - _Preservation: Button functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.2, 2.2, 3.1_

  - [x] 4.3 Update GradientOutlinedButton font size
    - Change from 16px to 13px
    - File: `lib/core/widgets/gradient_outlined_button.dart`
    - Line: `fontSize: 16,` → `fontSize: 13,`
    - Rationale: Creates clear hierarchy differentiation from primary buttons
    - _Bug_Condition: isBugCondition(input) where input.fontSize >= 16 AND input.hierarchyDifferentiation == false_
    - _Expected_Behavior: Secondary button text at 13px feels less prominent than primary_
    - _Preservation: Text rendering and accessibility unchanged (Requirement 3.6)_
    - _Requirements: 1.3, 1.6, 2.3, 2.6, 3.6_

  - [x] 4.4 Update GradientOutlinedButton icon size
    - Change from 20px to 16px
    - File: `lib/core/widgets/gradient_outlined_button.dart`
    - Line: `size: 20,` → `size: 16,`
    - Rationale: Creates proportional balance for secondary button icons
    - _Bug_Condition: isBugCondition(input) where input.iconSize >= 20_
    - _Expected_Behavior: Secondary icon at 16px feels proportional_
    - _Preservation: Icon rendering and alignment unchanged (Requirement 3.13)_
    - _Requirements: 1.4, 2.4, 3.13_

### Task 5: Create Tertiary Button Variant (Optional)

- [ ] 5. Create TertiaryButton widget for low-priority actions (OPTIONAL)
  - Create new widget file: `lib/core/widgets/tertiary_button.dart`
  - Implement TertiaryButton with minimal visual emphasis:
    - Vertical padding: 8px (AppSpacing.sm)
    - Horizontal padding: 12px (AppSpacing.md)
    - Font size: 13px
    - Icon size: 16px
    - No background fill (transparent or subtle hover state)
    - Border: optional subtle border or no border
    - Text color: secondary text color from theme
  - Use for: "Haritada Göster", settings items, utility actions, destructive actions
  - Rationale: Provides third tier in hierarchy system for de-emphasized actions
  - _Bug_Condition: isBugCondition(input) where input.hierarchyDifferentiation == false AND input.multipleActionsPresent == true_
  - _Expected_Behavior: Tertiary actions visually subordinate to primary and secondary_
  - _Preservation: All button functionality preserved (Requirement 3.1)_
  - _Requirements: 1.6, 1.10, 2.6, 2.10, 3.1_

---

## Phase 2: Screen-Specific Button Updates

### Task 6: Update Offers Screen Buttons

- [-] 6. Update Offers screen accept/reject buttons

  - [x] 6.1 Change accept button to secondary styling
    - File: `lib/features/offers/presentation/offers_screen.dart`
    - Change from `GradientButton` to `GradientOutlinedButton` for accept action
    - Rationale: Reduces visual prominence of repeated actions in list context
    - _Bug_Condition: isBugCondition(input) where input.visualWeight > input.surroundingContentWeight_
    - _Expected_Behavior: Accept button visually subordinate to offer information_
    - _Preservation: Accept functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.9, 1.14, 1.15, 1.16, 2.9, 2.14, 2.15, 2.16, 3.1_

  - [ ] 6.2 Change reject button to tertiary styling (if TertiaryButton created)
    - File: `lib/features/offers/presentation/offers_screen.dart`
    - Change from `GradientOutlinedButton` to `TertiaryButton` for reject action
    - Rationale: Further reduces visual prominence of destructive action
    - _Bug_Condition: isBugCondition(input) where input.hierarchyDifferentiation == false_
    - _Expected_Behavior: Reject button visually de-emphasized_
    - _Preservation: Reject functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.6, 1.10, 2.6, 2.10, 3.1_

  - [x] 6.3 Verify offer information hierarchy
    - Visually verify that offer information (player name, match title, location, date) is now more prominent than action buttons
    - Take screenshot for comparison with exploration test screenshots
    - _Requirements: 2.14, 2.15, 2.16_

### Task 7: Update Match Detail Screen Buttons

- [-] 7. Update Match Detail screen buttons

  - [x] 7.1 Verify "Katıl" (Join) button in bottom bar
    - File: `lib/features/match_listings/presentation/match_listing_detail_screen.dart`
    - Keep as `GradientButton` (primary CTA) but verify reduced dimensions from Task 3
    - Verify bottom bar feels more compact after dimension reduction
    - Take screenshot for comparison with exploration test screenshots
    - _Bug_Condition: isBugCondition(input) where input.buttonHeight >= 48_
    - _Expected_Behavior: Join button maintains CTA emphasis with reduced dimensions_
    - _Preservation: Join functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.1, 2.1, 2.7, 3.1_

  - [ ] 7.2 Change "Haritada Göster" (Show on Map) button to tertiary styling
    - File: `lib/features/match_listings/presentation/match_listing_detail_screen.dart`
    - Change from `GradientOutlinedButton` to `TertiaryButton` (if created) or apply minimal styling
    - Rationale: This utility action should be visually subordinate to primary join action
    - _Bug_Condition: isBugCondition(input) where input.hierarchyDifferentiation == false_
    - _Expected_Behavior: Map button visually de-emphasized compared to join button_
    - _Preservation: Map navigation functionality unchanged (Requirement 3.2)_
    - _Requirements: 1.6, 2.6, 3.2_

  - [x] 7.3 Update any additional action buttons in match cards
    - Review match listing cards for additional action buttons
    - Apply appropriate hierarchy tier (secondary or tertiary) based on action importance
    - _Requirements: 1.6, 1.11, 1.12, 2.6, 2.11, 2.12_

### Task 8: Update Profile Screen Buttons

- [-] 8. Update Profile screen buttons

  - [ ] 8.1 Change "Çıkış Yap" (Logout) button to tertiary styling
    - File: `lib/features/profile/presentation/profile_screen.dart`
    - Change from `GradientOutlinedButton` to `TertiaryButton` (if created) or apply minimal styling
    - Rationale: Destructive action should be visually de-emphasized to prevent accidental activation
    - _Bug_Condition: isBugCondition(input) where input.hierarchyDifferentiation == false AND destructive action_
    - _Expected_Behavior: Logout button visually de-emphasized_
    - _Preservation: Logout functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.10, 2.10, 3.1_

  - [x] 8.2 Review and update settings/edit buttons
    - File: `lib/features/profile/presentation/profile_screen.dart`
    - Apply appropriate hierarchy tier to edit profile, settings, and other utility buttons
    - Verify buttons feel proportional to profile content (avatar, name, stats)
    - _Requirements: 1.6, 1.17, 2.6, 2.17_

  - [x] 8.3 Update user profile screen buttons
    - File: `lib/features/profile/presentation/user_profile_screen.dart`
    - Review and update any action buttons (follow, message, etc.)
    - Apply appropriate hierarchy tier based on action importance
    - _Requirements: 1.6, 2.6_

  - [x] 8.4 Update profile setup screen buttons
    - File: `lib/features/profile/presentation/profile_setup_screen.dart`
    - Review and update form submission buttons
    - Keep primary styling for main CTA but verify reduced dimensions from Task 3
    - _Requirements: 1.1, 2.1, 2.7_

### Task 9: Update Form Screen Buttons

- [x] 9. Update form screen submit buttons

  - [x] 9.1 Update match listing create screen submit button
    - File: `lib/features/match_listings/presentation/match_listing_create_screen.dart`
    - Keep as `GradientButton` (primary CTA) but verify reduced dimensions from Task 3
    - Verify button feels proportional to form fields and section headers
    - _Bug_Condition: isBugCondition(input) where input.visualWeight > input.surroundingContentWeight_
    - _Expected_Behavior: Submit button maintains CTA emphasis with proportional balance_
    - _Preservation: Form submission functionality unchanged (Requirement 3.3)_
    - _Requirements: 1.17, 2.7, 2.17, 3.3_

  - [x] 9.2 Update player listing create screen submit button
    - File: `lib/features/player_listings/presentation/player_listing_create_screen.dart`
    - Keep as `GradientButton` (primary CTA) but verify reduced dimensions from Task 3
    - Verify button feels proportional to form content
    - _Requirements: 1.17, 2.7, 2.17, 3.3_

  - [x] 9.3 Review and update any secondary form actions
    - Review form screens for cancel, reset, or other secondary actions
    - Apply secondary or tertiary styling as appropriate
    - _Requirements: 1.6, 2.6_

### Task 10: Update Dialog Buttons

- [x] 10. Update dialog overlay confirmation buttons

  - [x] 10.1 Apply compact dimensions to dialog buttons
    - Review all dialog implementations across the app
    - For dialog buttons, consider applying even more compact dimensions:
      - Primary dialog button: 10px vertical padding (instead of 12px)
      - Secondary dialog button: 8px vertical padding (instead of 10px)
    - Rationale: Constrained dialog space benefits from more compact button proportions
    - _Bug_Condition: isBugCondition(input) where input.buttonHeight >= 48 AND constrained dialog space_
    - _Expected_Behavior: Dialog buttons feel proportional to dialog content_
    - _Preservation: Dialog functionality unchanged (Requirement 3.1)_
    - _Requirements: 1.11, 2.11, 3.1_

  - [x] 10.2 Verify dialog button hierarchy
    - Ensure accept/confirm actions use primary styling
    - Ensure cancel/dismiss actions use secondary or tertiary styling
    - Verify clear visual differentiation between accept and cancel
    - _Requirements: 1.6, 2.6_

### Task 11: Update Login/Auth Screen Buttons

- [x] 11. Update Login and Auth screen buttons
  - File: `lib/features/auth/presentation/login_screen.dart`
  - Keep primary CTA styling for main login/signup buttons
  - Verify reduced dimensions from Task 3 improve proportional balance
  - Review any secondary actions (forgot password, social login) and apply appropriate hierarchy
  - _Preservation: Auth flows unchanged (Requirement 3.4)_
  - _Requirements: 1.1, 2.1, 2.7, 3.4_

---

## Phase 3: Verification (AFTER Fix)

### Task 12: Verify Bug Condition Exploration Test Passes

- [x] 12. Verify bug condition exploration test now passes
  - **Property 1: Expected Behavior** - Button Proportional Dimensions
  - **IMPORTANT**: Re-run the SAME test from Task 1 - do NOT write a new test
  - The test from Task 1 encodes the expected behavior
  - When this test passes, it confirms the expected behavior is satisfied
  - Run bug condition exploration test from Task 1
  - **EXPECTED OUTCOME**: Test PASSES (confirms bug is fixed)
  - Verify all assertions pass:
    - GradientButton vertical padding = 12px ✓
    - GradientButton horizontal padding = 16px ✓
    - GradientButton font size = 14px ✓
    - GradientButton icon size = 18px ✓
    - GradientOutlinedButton vertical padding = 10px ✓
    - GradientOutlinedButton horizontal padding = 12px ✓
    - GradientOutlinedButton font size = 13px ✓
    - GradientOutlinedButton icon size = 16px ✓
    - Button heights reduced (primary ~44px, secondary ~40px) ✓
    - Buttons visually subordinate to content headings ✓
    - Clear hierarchy differentiation between button tiers ✓
  - Compare before/after screenshots to validate visual hierarchy improvements
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.6, 2.11, 2.14, 2.17, 2.18_

### Task 13: Verify Preservation Tests Still Pass

- [x] 13. Verify preservation tests still pass
  - **Property 2: Preservation** - Button Functionality and Accessibility
  - **IMPORTANT**: Re-run the SAME tests from Task 2 - do NOT write new tests
  - Run preservation property tests from Task 2
  - **EXPECTED OUTCOME**: Tests PASS (confirms no regressions)
  - Verify all preservation properties pass:
    - Button onPressed callbacks execute identically ✓
    - Disabled state behavior preserved ✓
    - Loading state behavior preserved ✓
    - Pressed state AnimatedScale feedback preserved ✓
    - Touch targets remain >= 44x44 ✓
    - Gradient styling and shadow effects unchanged ✓
    - Navigation flows preserved ✓
    - Semantic labels and accessibility properties unchanged ✓
  - Confirm all tests still pass after fix (no regressions)
  - _Requirements: 3.1, 3.2, 3.3, 3.5, 3.6, 3.7, 3.11, 3.12, 3.13, 3.14_

### Task 14: Visual Regression Testing

- [x] 14. Perform comprehensive visual regression testing
  - Take screenshots of all affected screens after fix implementation
  - Compare with exploration test screenshots (Task 1) to validate improvements
  - Screens to verify:
    - Offers screen (accept/reject buttons)
    - Match detail screen (join button, map button)
    - Profile screen (logout button, settings buttons)
    - Form screens (submit buttons)
    - Dialog overlays (confirmation buttons)
    - Login/Auth screens (login/signup buttons)
  - Verify visual hierarchy improvements:
    - Buttons feel proportionally balanced with content
    - Content headings and information are more prominent than buttons
    - Clear hierarchy differentiation between button tiers
    - Layouts feel calmer and more intentional
    - No "mobile template" appearance
  - Document any unexpected visual issues or regressions
  - _Requirements: 2.1, 2.6, 2.11, 2.14, 2.16, 2.17, 2.18, 2.19_

### Task 15: Accessibility Testing

- [x] 15. Verify accessibility compliance
  - Test all button types with accessibility tools:
    - Verify minimum 44x44 touch targets maintained
    - Verify semantic labels present and correct
    - Verify sufficient color contrast for text and borders
    - Verify focus indicators visible and clear
    - Verify screen reader announcements correct
  - Test with actual accessibility features:
    - Enable TalkBack (Android) or VoiceOver (iOS)
    - Navigate through screens using screen reader
    - Verify all buttons are discoverable and actionable
    - Verify button roles and states announced correctly
  - Document any accessibility issues found
  - _Requirements: 3.5, 3.6, 3.7_

---

## Phase 4: Checkpoint

### Task 16: Final Checkpoint

- [ ] 16. Checkpoint - Ensure all tests pass and visual hierarchy is improved
  - Run all unit tests and verify they pass
  - Run all property-based tests and verify they pass
  - Run all integration tests and verify they pass
  - Review all screenshots and verify visual hierarchy improvements
  - Review accessibility test results and verify compliance
  - Verify no regressions in functionality, navigation, or state management
  - Ask the user if questions arise or if additional refinements are needed
  - Document any remaining issues or future improvement opportunities
  - _Requirements: All requirements validated_

---

## Notes

### Testing Approach

- **Exploration tests (Task 1)**: Measure button dimensions on UNFIXED code, expect FAILURE
- **Preservation tests (Task 2)**: Test functionality on UNFIXED code, expect PASS
- **Fix verification (Task 12)**: Re-run exploration tests on FIXED code, expect PASS
- **Preservation verification (Task 13)**: Re-run preservation tests on FIXED code, expect PASS

### Button Hierarchy Tiers

- **Primary (GradientButton)**: Main CTAs, form submissions, critical actions
  - Dimensions: 12px vertical padding, 16px horizontal padding, 14px font, 18px icon
- **Secondary (GradientOutlinedButton)**: Supporting actions, alternative choices
  - Dimensions: 10px vertical padding, 12px horizontal padding, 13px font, 16px icon
- **Tertiary (TertiaryButton - optional)**: Utility actions, destructive actions, low-priority actions
  - Dimensions: 8px vertical padding, 12px horizontal padding, 13px font, 16px icon

### Context-Specific Guidelines

- **Offers Screen**: Use secondary styling for accept/reject (not primary)
- **Match Detail**: Keep primary for join, use tertiary for map/utility actions
- **Profile**: Use tertiary for logout and settings
- **Dialogs**: Use compact dimensions (10px/8px vertical padding)
- **Forms**: Keep primary for submit buttons

### Preservation Guarantees

All existing functionality, navigation, state management, accessibility, and user interactions must remain unchanged. Only visual dimensions (height, padding, font size, icon size) are modified to improve proportional balance and hierarchy.
