import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/widgets/sidedrawer.dart';

void main() {
  testWidgets('mostrar el menu en el sidedrawer', (WidgetTester tester) async {
    //ARRANGE
    await tester.pumpWidget(const MaterialApp(home: SideDrawer()));

    Finder opt = find.text("Organizaciones");
    expect(opt, findsOneWidget);
  });
}
