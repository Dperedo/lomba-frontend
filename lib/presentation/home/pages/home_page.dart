import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/sidedrawer/pages/sidedrawer_page.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

///HomePage del sistema, en el futuro debe cambiar a página principal
///
///Por ahora sólo muestra un mensaje distinto cuando el usuario está o no
///logueado.
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
              return const Text("Bienvenido usuario logueado!");
            } else {
              return const Text("Usuario anónimo. Bienvenido.");
            }
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          context.read<HomeBloc>().add(const OnHomeLoading());
          return const Text("Bienvenido...");
        }),
      ),
    );
  }
}
