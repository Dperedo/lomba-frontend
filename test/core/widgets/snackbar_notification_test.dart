import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:lomba_frontend/core/widgets/snackbar_notification.dart';

void main() {
  testWidgets('snackBarNotify - mostrar!', (WidgetTester tester) async {
    //arrange
    const text = 'muestra!';

    Widget testWidget = const MediaQuery(
        data: MediaQueryData(size: Size(400, 400)),
        child: MaterialApp(home: TestSnackBarNotifyPage(widget: Text(text))));

    //act
    await tester.pumpWidget(testWidget);
    final textWidget = find.text(text);

    expect(textWidget, findsOneWidget);
  });
}

class TestSnackBarNotifyPage extends StatelessWidget {
  const TestSnackBarNotifyPage({Key? key, required this.widget})
      : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    // snackBarNotify(context, 'muestra!', Icons.image);

    return ScaffoldManager(
      title: AppBar(),
      child: SingleChildScrollView(child: widget),
    );
  }
}
