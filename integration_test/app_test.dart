import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import "package:front_lomba/main.dart" as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Hacer login en Lomba', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final login = find.byKey(const Key("input_login"));
      final pass = find.byKey(const Key("input_password"));
      final ingresar = find.byKey(const Key("button_enter"));
      final homeinicio = find.byKey(const Key("page_inicio"));

      await tester.enterText(login, "superadmin");
      await tester.enterText(pass, "superadmin");
      await tester.tap(ingresar);
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("page_inicio")), findsOneWidget);

/*
      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
      */
    });
  });
}
