part of 'item_list_cubit.dart';

sealed class ItemListState {}

final class ItemListLoading extends ItemListState {}

final class ItemListSuccess extends ItemListState {
  final List<RealEstate> itemsList;
  final bool hasMore;
  final int? currentPage;
  ItemListSuccess(this.currentPage,
      {required this.itemsList, this.hasMore = false});
}

final class ItemListFailure extends ItemListState {
  final String message;
  final List<RealEstate>? previousItems;
  ItemListFailure(this.previousItems, {required this.message});
}

final class ItemListInitial extends ItemListState {}
