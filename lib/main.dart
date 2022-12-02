import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/presentation/bloc/home_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/presentation/pages/home_page.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/login/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
        BlocProvider(create: (_) => di.locator<HomeBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
