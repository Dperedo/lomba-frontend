import 'package:equatable/equatable.dart';

abstract class PopularEvent extends Equatable{
  const PopularEvent();

  @override
  List<Object?> get props => [];
}

class OnPopularLoad extends PopularEvent {
  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnPopularLoad(
    this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize
  );

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}