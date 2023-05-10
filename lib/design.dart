import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lomba_frontend/presentation/design/page/design_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //usePathUrlStrategy();
  //debugPaintSizeEnabled = true;
  runApp(const MyDesign());
}

class MyDesign extends StatefulWidget {
  const MyDesign({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyDesign();
}

class _MyDesign extends State<MyDesign> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const DesignPage());
  }
}
