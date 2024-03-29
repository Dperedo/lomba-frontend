import 'package:equatable/equatable.dart';

abstract class ToBeApprovedEvent extends Equatable{
  const ToBeApprovedEvent();

  @override
  List<Object?> get props => [];
}

class OnToBeApprovedLoad extends ToBeApprovedEvent {
  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnToBeApprovedLoad(
    this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize
  );

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}