part of 'item_list_cubit.dart';

@immutable
sealed class ItemListState {}

final class ItemListLoading extends ItemListState {}

final class ItemListSuccess extends ItemListState {
  final List<RealEstate> itemsList;
  final bool hasMore;
  ItemListSuccess({required this.itemsList, this.hasMore = false});
}

final class ItemListFailure extends ItemListState {
  final String message;
  ItemListFailure({required this.message});
}

final class ItemListInitial extends ItemListState {}
