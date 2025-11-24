import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddLostItem widget placeholder', (WidgetTester tester) async {
    // TODO: implement widget test for AddLostItem UI
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('placeholder'))));
    expect(find.text('placeholder'), findsOneWidget);
  });
}
