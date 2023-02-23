import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_state.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_bloc.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_event.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_state.dart';

import '../../nav/bloc/nav_bloc.dart';
import '../../nav/bloc/nav_event.dart';

class RouterPage extends StatelessWidget {
  final NavItem naveItem;
  
  const RouterPage({
    Key? key,
    required this.naveItem,
  }) : super(key: key);

  void _handleItemRoute(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool called = true;
    return BlocBuilder<RouterPageBloc, RouterPageState>(
      builder: (context, state) {
        if(state is RouterPageEmpty && called) {
          context.read<RouterPageBloc>().add(OnRouterPageLoading(naveItem));
          called = false;
        } else if(state is RouterPageRole) {
          _handleItemRoute(context, naveItem);
          context.read<RouterPageBloc>().add(const OnRouterPageReset());
        } else if(state is RouterPageError) {
          _handleItemRoute(context, NavItem.pageHome);
          context.read<RouterPageBloc>().add(const OnRouterPageReset());
        }
        return const SizedBox();
      },
    );
  }
}
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