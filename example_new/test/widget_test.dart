import 'package:flutter_test/flutter_test.dart';

import 'package:example_new/main.dart';

void main() {
  testWidgets('App renders home page', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperGetDemoApp());
    await tester.pumpAndSettle();

    // Verify the home page title is shown
    expect(find.text('🚀 Super Get Showcase'), findsOneWidget);
    expect(find.text('Explore Super Get Features'), findsOneWidget);

    // Verify feature cards are present
    expect(find.text('Reactive Counter'), findsOneWidget);
    expect(find.text('Todo List'), findsOneWidget);
    expect(find.text('API Demo'), findsOneWidget);
  });
}
