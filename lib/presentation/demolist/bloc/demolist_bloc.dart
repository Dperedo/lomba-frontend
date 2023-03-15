import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/demolist/bloc/demolist_event.dart';
import 'package:lomba_frontend/presentation/demolist/bloc/demolist_state.dart';

import '../../../core/fakedata.dart';

class DemoListBloc extends Bloc<DemoListEvent, DemoListState> {
  DemoListBloc() : super(DemoListStartState()) {
    on<OnDemoListStarter>((event, emit) => emit(DemoListStartState()));

    on<OnDemoListSearch>(
      (event, emit) async {
        //lanza estado para mostrar el círculo de progreso
        emit(DemoListLoadingState());

//las siguientes líneas solo existen con el propósito de cargar información de pruebas.
//para implementar lo siguiente se deben invocar nuevos casos de uso.

        List<TestRandomItem> filtered = testRandomItemList
            .where((element) =>
                element.id
                    .toLowerCase()
                    .contains(event.searchText.toLowerCase()) ||
                element.name
                    .toLowerCase()
                    .contains(event.searchText.toLowerCase()) ||
                element.text
                    .toLowerCase()
                    .contains(event.searchText.toLowerCase()) ||
                element.num.toString().toLowerCase().contains(event.searchText))
            .toList();

        List<TestRandomItem> ordered = filtered;

        if (event.fieldsOrder.containsKey('id')) {
          ordered.sort((a, b) => a.id.compareTo(b.id));
        }
        if (event.fieldsOrder.containsKey('name')) {
          ordered.sort((a, b) => a.name.compareTo(b.name));
        }
        if (event.fieldsOrder.containsKey('num')) {
          ordered.sort((a, b) => a.num.compareTo(b.num));
        }
        if (event.fieldsOrder.containsKey('text')) {
          ordered.sort((a, b) => a.text.compareTo(b.text));
        }

        if (event.fieldsOrder.containsValue(-1)) {
          ordered = ordered.reversed.toList();
        }

        List<TestRandomItem> listPaged = ordered
            .skip((event.pageIndex - 1) * event.pageSize)
            .take(event.pageSize)
            .toList();

        int totalPages = (filtered.length / event.pageSize).ceil();
        if (totalPages == 0) totalPages = 1;

        //emite estado con la información de la pantalla.
        emit(DemoListLoadedState(
            event.searchText,
            event.fieldsOrder,
            event.pageIndex,
            event.pageSize,
            listPaged,
            listPaged.length,
            filtered.length,
            totalPages));
      },
    );
  }
}
