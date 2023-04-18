import 'dart:ffi';

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
  final Map<String, dynamic>? args;
  const RouterPage({
    Key? key,
    required this.naveItem,
    this.args,
  }) : super(key: key);

  void _handleItemRoute(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item, context, args));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool called = true;
    return BlocBuilder<RouterPageBloc, RouterPageState>(
      builder: (context, state) {
        if (state is RouterPageEmpty && called) {
          context.read<RouterPageBloc>().add(OnRouterPageLoading(naveItem));
          called = false;
        } else if (state is RouterPageRole) {
          _handleItemRoute(context, naveItem);
          context.read<RouterPageBloc>().add(const OnRouterPageReset());
        } else if (state is RouterPageError) {
          _handleItemRoute(context, NavItem.pageRecent);
          context.read<RouterPageBloc>().add(const OnRouterPageReset());
        }
        return const SizedBox();
      },
    );
  }
}
