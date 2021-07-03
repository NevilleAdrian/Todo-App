import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morphosis_flutter_demo/main.dart' as app;

void main() {
  group('Test Bottom Navigation Bar', () {
    testWidgets('Bottom Nav Test', (tester) async {
      //load the splashscreen
      app.main();
      await tester.pumpAndSettle();

      find.byKey(Key('main'));
      await tester.pumpAndSettle();

      //click on bottom nav bar
      await tester.tap((find.byType(Text).last));
      await tester.pumpAndSettle();
    });
  });
}
