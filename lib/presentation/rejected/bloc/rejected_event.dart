import 'package:equatable/equatable.dart';

abstract class RejectedEvent extends Equatable{
  const RejectedEvent();

  @override
  List<Object?> get props => [];
}
class OnRejectedLoad extends RejectedEvent {
  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnRejectedLoad(
    this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize
  );

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}