import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lost_found_app/ui/screens/add_lost_item.dart';

void main() {
  testWidgets('Add Lost Item UI loads correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AddLostItemScreen(),
      ),
    );

    expect(find.text('Add Lost Item'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Submit'), findsOneWidget);
  });
}
