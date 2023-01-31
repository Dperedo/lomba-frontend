import 'package:equatable/equatable.dart';

import '../../../core/fakedata.dart';

///Interfaz de estados para DemoList
abstract class DemoListState extends Equatable {
  const DemoListState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la demo list.
class DemoListStartState extends DemoListState {}

//Estado de carga momentáneo.
class DemoListLoadingState extends DemoListState {}

//Estado con la lista carga con búsqueda, filtro y paginado.
class DemoListLoadedState extends DemoListState {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final List<TestRandomItem> listRandomItems;
  final int itemCount;
  final int totalItems;
  final int totalPages;
  const DemoListLoadedState(
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.listRandomItems,
      this.itemCount,
      this.totalItems,
      this.totalPages);
}
