import 'package:equatable/equatable.dart';

abstract class UploadedEvent extends Equatable{
  const UploadedEvent();

  @override
  List<Object?> get props => [];
}
class OnUploadedLoad extends UploadedEvent {
  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnUploadedLoad(
    this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize
  );

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}