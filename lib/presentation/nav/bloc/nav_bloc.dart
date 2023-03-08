import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../voted/bloc/voted_bloc.dart';
import '../../voted/bloc/voted_event.dart';
import 'nav_event.dart';
import 'nav_state.dart';

///BLOC de navegación para las pantallas de la aplicación.
///
///Considera sólo un evento [NavigateTo] que indica a qué página se
///desea navegar, con eso emite un estado con el destino a navegar.

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavState(NavItem.pageHome)) {
    on<NavigateTo>(
      (event, emit) async {
        if (event.destination != state.selectedItem) {
          if (state.selectedItem == NavItem.pageVoted) {
            event.context.read<VotedBloc>().add(OnVotedStarter());
          }

          emit(NavState(event.destination));
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
