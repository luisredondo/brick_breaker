import 'package:brick_breaker/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  Future<void> pumpAnimation(Widget child, {Duration? initialDelay}) async {
    await pumpWidget(child);
    await pump(0.ms);
    if (initialDelay != null) {
      await pump(initialDelay);
    }
  }
}

void main() {
  group('OverlayScreen', () {
    test('can be instantiated', () {
      expect(
        const OverlayScreen(
          title: 'title',
          subtitle: 'subtitle',
        ),
        isA<OverlayScreen>(),
      );
    });

    group('renders', () {
      late Widget widgetToTest;

      setUp(() {
        widgetToTest = const MaterialApp(
          home: OverlayScreen(
            title: 'title',
            subtitle: 'subtitle',
          ),
        );
      });

      testWidgets('properly', (tester) async {
        await tester.pumpAnimation(widgetToTest);
        expect(find.byType(OverlayScreen), findsOneWidget);
      });

      group('title', () {
        testWidgets('correctly', (tester) async {
          await tester.pumpAnimation(widgetToTest);
          expect(find.text('title'), findsOneWidget);
        });

        testWidgets('with correct style', (tester) async {
          await tester.pumpAnimation(widgetToTest);
          final context = tester.element(find.byType(OverlayScreen));
          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is Text &&
                  widget.style == Theme.of(context).textTheme.headlineLarge,
            ),
            findsOneWidget,
          );
        });
      });

      group('subtitle', () {
        testWidgets('correctly', (tester) async {
          await tester.pumpAnimation(widgetToTest);
          expect(find.text('subtitle'), findsOneWidget);
        });

        testWidgets('with correct style', (tester) async {
          await tester.pumpAnimation(widgetToTest);
          final context = tester.element(find.byType(OverlayScreen));
          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is Text &&
                  widget.style == Theme.of(context).textTheme.headlineSmall,
            ),
            findsOneWidget,
          );
        });
      });
    });
  });
}
