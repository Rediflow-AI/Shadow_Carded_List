import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadowed_carded_list/shadowed_carded_list.dart';

void main() {
  testWidgets('renders header, items and footer', (WidgetTester tester) async {
    final items = List.generate(3, (i) => 'item-$i');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 300,
            child: CardedList<String>(
              header: const Text('HEADER'),
              footer: const Text('FOOTER'),
              items: items,
              itemBuilder: (context, index) => Text(items[index]),
            ),
          ),
        ),
      ),
    );

    // Header and footer present
    expect(find.text('HEADER'), findsOneWidget);
    expect(find.text('FOOTER'), findsOneWidget);

    // Items present
    for (var i = 0; i < items.length; i++) {
      expect(find.text(items[i]), findsOneWidget);
    }
  });

  testWidgets('shows empty message when items empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 200,
            child: CardedList<String>(
              header: const Text('H'),
              items: const [],
              itemBuilder: (_, __) => const SizedBox.shrink(),
              emptyListMessage: 'Nothing here',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Nothing here'), findsOneWidget);
  });
}
