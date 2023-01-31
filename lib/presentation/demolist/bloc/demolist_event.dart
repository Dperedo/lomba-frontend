import 'package:equatable/equatable.dart';

abstract class DemoListEvent extends Equatable {
  const DemoListEvent();

  @override
  List<Object?> get props => [];
}

class OnDemoListSearch extends DemoListEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  const OnDemoListSearch(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);
}
