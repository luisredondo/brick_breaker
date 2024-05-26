import 'package:brick_breaker/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScoreCard', () {
    final score = ValueNotifier<int>(0);

    test('can be instantiated', () {
      expect(ScoreCard(score: score), isA<ScoreCard>());
    });

    group('renders', () {
      late Widget widgetToTest;

      setUp(() {
        widgetToTest = MaterialApp(home: ScoreCard(score: score));
      });

      testWidgets('properly', (tester) async {
        await tester.pumpWidget(widgetToTest);
        expect(find.byType(ScoreCard), findsOneWidget);
      });

      group('text', () {
        testWidgets('correctly', (tester) async {
          await tester.pumpWidget(widgetToTest);
          expect(
            find.text('SCORE: 0'),
            findsOneWidget,
          );
        });

        testWidgets('with correct styles', (tester) async {
          await tester.pumpWidget(widgetToTest);
          final context = tester.element(find.byType(ScoreCard));
          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is Text &&
                  widget.style == Theme.of(context).textTheme.titleLarge,
            ),
            findsOneWidget,
          );
        });
      });
    });

    group('updates', () {
      testWidgets('when score changes', (tester) async {
        await tester.pumpWidget(MaterialApp(home: ScoreCard(score: score)));
        expect(find.text('SCORE: 0'), findsOneWidget);
        score.value = 5;
        await tester.pump();
        expect(find.text('SCORE: 5'), findsOneWidget);
      });
    });
  });
}
