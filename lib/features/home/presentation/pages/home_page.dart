import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/widgets/sidedrawer.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const SideDrawer(
        key: ValueKey("sidedrawer"),
      ),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoaded) {
            if (state.validLogin) {
              return const Text("Bienvenido usuario!");
            } else {
              return const Text("Welcome anonymous!");
            }
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          context.read<HomeBloc>().add(const OnHomeLoading());
          return const Text("Welcome!");
        }),
      ),
    );
  }
}
