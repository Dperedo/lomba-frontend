import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/sidedrawer.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/home_event.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoaded) {
            if (state.validLogin) {
              return const Text("Welcome!");
            } else {
              return const Text("Welcome!");
            }
          }
          context.read<HomeBloc>().add(const OnHomeLoading());
          return const Text("Welcome!");
        }),
      ),
      drawer: const SideDrawer(),
    );
  }
}
