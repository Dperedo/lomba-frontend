import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_state.dart';

import '../../presentation/nav/bloc/nav_bloc.dart';
import '../../presentation/nav/bloc/nav_event.dart';

class RouterPage extends StatelessWidget {
  final NavItem naveItem;
  const RouterPage({
    Key? key,
    required this.naveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//ESTO ES AQUI EN EL PAGE
    //invocas un evento al Bloc
    //OnLoadingRouterPage
    //le pasas de parámetro el NavItem

//ESTO ES EN EL BLOC
    //en el Bloc para el evento recién mencionado
    //vas a ejecutar el caso de uso de las opciones de menú
    //y vas a preguntar si dentro de está lista está el NavItem
    //o mejor dicho, si acaso esta lista contiene el NavItem especificado
    //si lo contiene, entonces emitimos un estado de => EstadoOso

//ESTO ES AQUI EN EL PAGE
    //que al aplicarse entonces salta o navega o va a la página mencionada
    //¿cómo? llamando al _handleItemRoute
    // _handleItemRoute(context, naveItem);

//¿y si no contiene la lista al NavItem?
//Lo devolvemos al Home.

    _handleItemRoute(context, naveItem);
    return const SizedBox();
  }

  void _handleItemRoute(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}
