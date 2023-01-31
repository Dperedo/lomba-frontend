import 'package:equatable/equatable.dart';

class SortModel extends Equatable {
  final Map<String, int>? fieldsOrder;
  const SortModel(this.fieldsOrder);

  @override
  List<Object> get props => [fieldsOrder!];
}
