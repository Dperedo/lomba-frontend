import 'package:equatable/equatable.dart';

class ModelContainer<T> extends Equatable {
  const ModelContainer(
      this.items,
      this.currentItemCount,
      this.itemsPerPage,
      this.startIndex,
      this.totalItems,
      this.pageIndex,
      this.totalPages,
      this.kind);
  final List<T> items;
  final int currentItemCount;
  final int? itemsPerPage;
  final int? startIndex;
  final int? totalItems;
  final int? pageIndex;
  final int? totalPages;
  final String? kind;
  @override
  List<Object> get props => [items, currentItemCount];

  factory ModelContainer.empty() {
    return const ModelContainer([], 0, null, null, null, null, null, "");
  }
  factory ModelContainer.fromItems(List<T> items) {
    return ModelContainer(
        items, items.length, null, null, null, null, null, "");
  }
  factory ModelContainer.fromItem(T item) {
    return ModelContainer([item], 1, null, null, null, null, null, "");
  }
}
