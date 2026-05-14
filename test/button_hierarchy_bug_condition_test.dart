import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';

/// **Bug Condition Exploration Test - Button Action Hierarchy Refinement**
///
/// **Validates: Requirements 1.1, 1.2, 1.3, 1.4, 1.6, 1.7, 1.11, 1.14, 1.17, 1.18**
///
/// **CRITICAL**: This test MUST FAIL on unfixed code - failure confirms the bug exists
/// **DO NOT attempt to fix the test or the code when it fails**
/// **NOTE**: This test encodes the expected behavior - it will validate the fix when it passes after implementation
/// **GOAL**: Surface counterexamples that demonstrate buttons have excessive dimensions that dominate content
///
/// This test verifies:
/// 1. GradientButton vertical padding (expect >= 16px on unfixed code, should be 12px)
/// 2. GradientButton horizontal padding (expect >= 20px on unfixed code, should be 16px)
/// 3. GradientButton font size (expect >= 16px on unfixed code, should be 14px)
/// 4. GradientButton icon size (expect >= 20px on unfixed code, should be 18px)
/// 5. GradientButton height (expect >= 48px on unfixed code, should be ~44px)
/// 6. GradientOutlinedButton vertical padding (expect >= 16px on unfixed code, should be 10px)
/// 7. GradientOutlinedButton horizontal padding (expect >= 20px on unfixed code, should be 12px)
/// 8. GradientOutlinedButton font size (expect >= 16px on unfixed code, should be 13px)
/// 9. GradientOutlinedButton icon size (expect >= 20px on unfixed code, should be 16px)
/// 10. Button visual weight compared to content (expect buttons dominate on unfixed code)
/// 11. Hierarchy differentiation (expect equal visual weight on unfixed code)
///
/// **EXPECTED OUTCOME**: Test FAILS (this is correct - it proves the bug exists)
void main() {
  group('Bug Condition Exploration - Button Proportional Dimensions', () {
    testWidgets(
      'Property 1.1: GradientButton vertical padding should be 12px (currently 16px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton uses oversized vertical padding
        // Expected behavior: vertical padding should be 12px (AppSpacing.md)
        // Current behavior: vertical padding is 16px (AppSpacing.lg)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(onPressed: () {}, label: 'Test Button'),
            ),
          ),
        );

        // Find the Container widget inside GradientButton
        final containerFinder = find.descendant(
          of: find.byType(GradientButton),
          matching: find.byType(Container),
        );

        expect(containerFinder, findsOneWidget);

        final container = tester.widget<Container>(containerFinder);
        final padding = container.padding as EdgeInsets?;

        // Expected behavior: vertical padding should be 12px
        // Current behavior: vertical padding is 16px (AppSpacing.lg)
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          padding?.top ?? 0,
          equals(12.0),
          reason:
              'GradientButton vertical padding should be 12px (AppSpacing.md). '
              'Current value: ${padding?.top ?? 0}px. '
              'This failure confirms the bug exists (oversized vertical padding).',
        );
      },
    );

    testWidgets(
      'Property 1.2: GradientButton horizontal padding should be 16px (currently 20px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton uses oversized horizontal padding
        // Expected behavior: horizontal padding should be 16px (AppSpacing.lg)
        // Current behavior: horizontal padding is 20px (AppSpacing.xl)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(onPressed: () {}, label: 'Test Button'),
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(GradientButton),
          matching: find.byType(Container),
        );

        expect(containerFinder, findsOneWidget);

        final container = tester.widget<Container>(containerFinder);
        final padding = container.padding as EdgeInsets?;

        // Expected behavior: horizontal padding should be 16px
        // Current behavior: horizontal padding is 20px (AppSpacing.xl)
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          padding?.left ?? 0,
          equals(16.0),
          reason:
              'GradientButton horizontal padding should be 16px (AppSpacing.lg). '
              'Current value: ${padding?.left ?? 0}px. '
              'This failure confirms the bug exists (oversized horizontal padding).',
        );
      },
    );

    testWidgets(
      'Property 1.3: GradientButton font size should be 14px (currently 16px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton uses oversized font size
        // Expected behavior: font size should be 14px
        // Current behavior: font size is 16px

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(onPressed: () {}, label: 'Test Button'),
            ),
          ),
        );

        // Find the Text widget inside GradientButton
        final textFinder = find.descendant(
          of: find.byType(GradientButton),
          matching: find.text('Test Button'),
        );

        expect(textFinder, findsOneWidget);

        final textWidget = tester.widget<Text>(textFinder);
        final fontSize = textWidget.style?.fontSize ?? 0;

        // Expected behavior: font size should be 14px
        // Current behavior: font size is 16px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          fontSize,
          equals(14.0),
          reason:
              'GradientButton font size should be 14px. '
              'Current value: ${fontSize}px. '
              'This failure confirms the bug exists (oversized font size).',
        );
      },
    );

    testWidgets(
      'Property 1.4: GradientButton icon size should be 18px (currently 20px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton uses oversized icon size
        // Expected behavior: icon size should be 18px
        // Current behavior: icon size is 20px

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(
                onPressed: () {},
                label: 'Test Button',
                icon: Icons.check,
              ),
            ),
          ),
        );

        // Find the Icon widget inside GradientButton
        final iconFinder = find.descendant(
          of: find.byType(GradientButton),
          matching: find.byIcon(Icons.check),
        );

        expect(iconFinder, findsOneWidget);

        final iconWidget = tester.widget<Icon>(iconFinder);
        final iconSize = iconWidget.size ?? 0;

        // Expected behavior: icon size should be 18px
        // Current behavior: icon size is 20px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          iconSize,
          equals(18.0),
          reason:
              'GradientButton icon size should be 18px. '
              'Current value: ${iconSize}px. '
              'This failure confirms the bug exists (oversized icon size).',
        );
      },
    );

    testWidgets(
      'Property 1.5: GradientButton loading indicator size should be 18px (currently 20px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton uses oversized loading indicator
        // Expected behavior: loading indicator size should be 18px
        // Current behavior: loading indicator size is 20px

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(
                onPressed: () {},
                label: 'Test Button',
                isLoading: true,
              ),
            ),
          ),
        );

        // Find the SizedBox containing the CircularProgressIndicator
        final sizedBoxFinder = find.descendant(
          of: find.byType(GradientButton),
          matching: find.byType(SizedBox),
        );

        expect(sizedBoxFinder, findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        final size = sizedBox.height ?? 0;

        // Expected behavior: loading indicator size should be 18px
        // Current behavior: loading indicator size is 20px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          size,
          equals(18.0),
          reason:
              'GradientButton loading indicator size should be 18px. '
              'Current value: ${size}px. '
              'This failure confirms the bug exists (oversized loading indicator).',
        );
      },
    );

    testWidgets(
      'Property 1.6: GradientButton height should be ~44px (currently >= 48px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientButton has excessive height
        // Expected behavior: button height should be ~44px (12px padding * 2 + 14px font + line height)
        // Current behavior: button height is >= 48px (16px padding * 2 + 16px font + line height)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientButton(onPressed: () {}, label: 'Test Button'),
            ),
          ),
        );

        final buttonFinder = find.byType(GradientButton);
        expect(buttonFinder, findsOneWidget);

        final buttonSize = tester.getSize(buttonFinder);
        final buttonHeight = buttonSize.height;

        // Expected behavior: button height should be <= 46px (allowing for line height)
        // Current behavior: button height is >= 48px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          buttonHeight,
          lessThanOrEqualTo(46.0),
          reason:
              'GradientButton height should be ~44px (with reduced padding). '
              'Current value: ${buttonHeight}px. '
              'This failure confirms the bug exists (excessive button height).',
        );
      },
    );

    testWidgets(
      'Property 1.7: GradientOutlinedButton vertical padding should be 10px (currently 16px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientOutlinedButton uses oversized vertical padding
        // Expected behavior: vertical padding should be 10px (custom value for secondary buttons)
        // Current behavior: vertical padding is 16px (AppSpacing.lg)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientOutlinedButton(
                onPressed: () {},
                label: 'Test Button',
              ),
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(GradientOutlinedButton),
          matching: find.byType(Container),
        );

        expect(containerFinder, findsOneWidget);

        final container = tester.widget<Container>(containerFinder);
        final padding = container.padding as EdgeInsets?;

        // Expected behavior: vertical padding should be 10px
        // Current behavior: vertical padding is 16px (AppSpacing.lg)
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          padding?.top ?? 0,
          equals(10.0),
          reason:
              'GradientOutlinedButton vertical padding should be 10px (secondary button). '
              'Current value: ${padding?.top ?? 0}px. '
              'This failure confirms the bug exists (oversized vertical padding, no hierarchy differentiation).',
        );
      },
    );

    testWidgets(
      'Property 1.8: GradientOutlinedButton horizontal padding should be 12px (currently 20px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientOutlinedButton uses oversized horizontal padding
        // Expected behavior: horizontal padding should be 12px (AppSpacing.md)
        // Current behavior: horizontal padding is 20px (AppSpacing.xl)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientOutlinedButton(
                onPressed: () {},
                label: 'Test Button',
              ),
            ),
          ),
        );

        final containerFinder = find.descendant(
          of: find.byType(GradientOutlinedButton),
          matching: find.byType(Container),
        );

        expect(containerFinder, findsOneWidget);

        final container = tester.widget<Container>(containerFinder);
        final padding = container.padding as EdgeInsets?;

        // Expected behavior: horizontal padding should be 12px
        // Current behavior: horizontal padding is 20px (AppSpacing.xl)
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          padding?.left ?? 0,
          equals(12.0),
          reason:
              'GradientOutlinedButton horizontal padding should be 12px (AppSpacing.md). '
              'Current value: ${padding?.left ?? 0}px. '
              'This failure confirms the bug exists (oversized horizontal padding).',
        );
      },
    );

    testWidgets(
      'Property 1.9: GradientOutlinedButton font size should be 13px (currently 16px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientOutlinedButton uses oversized font size
        // Expected behavior: font size should be 13px (secondary button)
        // Current behavior: font size is 16px (same as primary)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientOutlinedButton(
                onPressed: () {},
                label: 'Test Button',
              ),
            ),
          ),
        );

        final textFinder = find.descendant(
          of: find.byType(GradientOutlinedButton),
          matching: find.text('Test Button'),
        );

        expect(textFinder, findsOneWidget);

        final textWidget = tester.widget<Text>(textFinder);
        final fontSize = textWidget.style?.fontSize ?? 0;

        // Expected behavior: font size should be 13px
        // Current behavior: font size is 16px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          fontSize,
          equals(13.0),
          reason:
              'GradientOutlinedButton font size should be 13px (secondary button). '
              'Current value: ${fontSize}px. '
              'This failure confirms the bug exists (oversized font size, no hierarchy differentiation).',
        );
      },
    );

    testWidgets(
      'Property 1.10: GradientOutlinedButton icon size should be 16px (currently 20px - EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: GradientOutlinedButton uses oversized icon size
        // Expected behavior: icon size should be 16px (secondary button)
        // Current behavior: icon size is 20px (same as primary)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GradientOutlinedButton(
                onPressed: () {},
                label: 'Test Button',
                icon: Icons.check,
              ),
            ),
          ),
        );

        final iconFinder = find.descendant(
          of: find.byType(GradientOutlinedButton),
          matching: find.byIcon(Icons.check),
        );

        expect(iconFinder, findsOneWidget);

        final iconWidget = tester.widget<Icon>(iconFinder);
        final iconSize = iconWidget.size ?? 0;

        // Expected behavior: icon size should be 16px
        // Current behavior: icon size is 20px
        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          iconSize,
          equals(16.0),
          reason:
              'GradientOutlinedButton icon size should be 16px (secondary button). '
              'Current value: ${iconSize}px. '
              'This failure confirms the bug exists (oversized icon size, no hierarchy differentiation).',
        );
      },
    );

    testWidgets(
      'Property 1.11: Button hierarchy differentiation - Primary vs Secondary dimensions (EXPECTED TO FAIL)',
      (tester) async {
        // This test verifies the bug condition: lack of hierarchy differentiation
        // Expected behavior: Primary buttons should be visually larger than secondary buttons
        // Current behavior: Both button types have similar dimensions (no clear hierarchy)

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  GradientButton(onPressed: () {}, label: 'Primary'),
                  const SizedBox(height: 16),
                  GradientOutlinedButton(onPressed: () {}, label: 'Secondary'),
                ],
              ),
            ),
          ),
        );

        final primaryFinder = find.byType(GradientButton);
        final secondaryFinder = find.byType(GradientOutlinedButton);

        expect(primaryFinder, findsOneWidget);
        expect(secondaryFinder, findsOneWidget);

        final primarySize = tester.getSize(primaryFinder);
        final secondarySize = tester.getSize(secondaryFinder);

        final primaryHeight = primarySize.height;
        final secondaryHeight = secondarySize.height;

        // Expected behavior: Primary button should be taller than secondary
        // Primary: ~44px (12px padding * 2 + 14px font + line height)
        // Secondary: ~43px (10px padding * 2 + 13px font + line height)
        // Difference should be at least 1px (combined with font/icon size differences for hierarchy)
        final heightDifference = primaryHeight - secondaryHeight;

        // This assertion WILL FAIL on unfixed code (which is correct - it proves the bug)
        expect(
          heightDifference,
          greaterThanOrEqualTo(1.0),
          reason:
              'Primary button should be taller than secondary button (at least 1px difference). '
              'Current difference: ${heightDifference}px (Primary: ${primaryHeight}px, Secondary: ${secondaryHeight}px). '
              'This failure confirms the bug exists (no hierarchy differentiation).',
        );
      },
    );

    test('Property 1.12: Document counterexamples found', () {
      // This test documents the counterexamples found during exploration
      // These counterexamples demonstrate the bug exists

      final counterexamples = <String, dynamic>{
        'oversized_dimensions': {
          'GradientButton_vertical_padding': '12px (EXPECTED - currently 16px)',
          'GradientButton_horizontal_padding':
              '16px (EXPECTED - currently 20px)',
          'GradientButton_font_size': '14px (EXPECTED - currently 16px)',
          'GradientButton_icon_size': '18px (EXPECTED - currently 20px)',
          'GradientButton_height': '~44px (EXPECTED - currently >= 48px)',
          'GradientOutlinedButton_vertical_padding':
              '10px (EXPECTED - currently 16px)',
          'GradientOutlinedButton_horizontal_padding':
              '12px (EXPECTED - currently 20px)',
          'GradientOutlinedButton_font_size':
              '13px (EXPECTED - currently 16px)',
          'GradientOutlinedButton_icon_size':
              '16px (EXPECTED - currently 20px)',
        },
        'hierarchy_issues': {
          'primary_vs_secondary_differentiation':
              'MISSING - both buttons have similar dimensions',
          'visual_weight': 'EXCESSIVE - buttons dominate surrounding content',
          'button_text_vs_headings':
              'INVERTED - button text (16px) equals or exceeds heading text',
        },
        'affected_screens': {
          'offers_screen': 'Accept/reject buttons dominate offer information',
          'match_detail_screen': 'Join button in bottom bar feels inflated',
          'profile_screen': 'Logout button has excessive visual weight',
          'dialog_overlays':
              'Confirmation buttons feel oversized in constrained space',
          'form_screens':
              'Submit buttons feel disproportionate to form content',
        },
        'root_cause_analysis': {
          'issue_1':
              'Excessive padding values (AppSpacing.lg=16px, AppSpacing.xl=20px)',
          'issue_2': 'Oversized typography (16px font size)',
          'issue_3': 'Oversized icons (20px icon size)',
          'issue_4':
              'Lack of hierarchy differentiation (all buttons same dimensions)',
          'issue_5': 'No context-specific scaling (same dimensions everywhere)',
        },
      };

      // Print counterexamples for documentation
      debugPrint('\n=== BUG CONDITION EXPLORATION RESULTS ===\n');
      debugPrint('Button Action Hierarchy Refinement:\n');
      counterexamples.forEach((category, details) {
        debugPrint('$category:');
        if (details is Map) {
          details.forEach((key, value) {
            debugPrint('  - $key: $value');
          });
        }
        debugPrint('');
      });
      debugPrint('=== END OF EXPLORATION RESULTS ===\n');

      // This test always passes - it's just for documentation
      expect(counterexamples.isNotEmpty, isTrue);
    });
  });
}
