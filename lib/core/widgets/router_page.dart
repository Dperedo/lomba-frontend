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
    _handleItemRoute(context, naveItem);
    return const SizedBox();
  }

  void _handleItemRoute(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}
