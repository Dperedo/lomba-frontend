import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

void main() {
  testWidgets('Formato según tamaño de pantalla: 1200',
      (WidgetTester tester) async {
    //arrange
    const text = 'muestra!';

    Widget testWidget = const MediaQuery(
        data: MediaQueryData(size: Size(1200, 400)),
        child: MaterialApp(
            home: TestBodyFormatterPage(
          widget: Text(text),
          screenWidth: 1200,
        )));

    //act
    await tester.pumpWidget(testWidget);
    final textWidget = find.text(text);

    expect(textWidget, findsOneWidget);
  });

  testWidgets('Formato según tamaño de pantalla: 1100',
      (WidgetTester tester) async {
    //arrange
    const text = 'muestra!';

    Widget testWidget = const MediaQuery(
        data: MediaQueryData(size: Size(1100, 600)),
        child: MaterialApp(
            home: TestBodyFormatterPage(
          widget: Text(text),
          screenWidth: 1100,
        )));

    //act
    await tester.pumpWidget(testWidget);
    final textWidget = find.text(text);

    expect(textWidget, findsOneWidget);
  });

  testWidgets('Formato según tamaño de pantalla: 400',
      (WidgetTester tester) async {
    //arrange
    const text = 'muestra!';

    Widget testWidget = const MediaQuery(
        data: MediaQueryData(size: Size(400, 600)),
        child: MaterialApp(
            home: TestBodyFormatterPage(
          widget: Text(text),
          screenWidth: 400,
        )));

    //act
    await tester.pumpWidget(testWidget);
    final textWidget = find.text(text);

    expect(textWidget, findsOneWidget);
  });
}

class TestBodyFormatterPage extends StatelessWidget {
  const TestBodyFormatterPage(
      {Key? key, required this.widget, required this.screenWidth})
      : super(key: key);
  final Widget widget;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return ScaffoldManager(
      title: AppBar(),
      child: SingleChildScrollView(
          child: Center(
              child: BodyFormatter(
        screenWidth: screenWidth,
        child: widget,
      ))),
    );
  }
}
