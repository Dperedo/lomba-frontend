import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/demolist/presentation/bloc/demolist_event.dart';
import 'package:lomba_frontend/features/demolist/presentation/bloc/demolist_state.dart';

import '../../../../core/fakedata.dart';

class DemoListBloc extends Bloc<DemoListEvent, DemoListState> {
  DemoListBloc() : super(DemoListStartState()) {
    on<OnDemoListSearch>(
      (event, emit) async {
        emit(DemoListLoadingState());

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

        emit(DemoListLoadedState(event.searchText, event.fieldsOrder,
            event.pageIndex, event.pageSize, listPaged));
      },
    );
  }
}
