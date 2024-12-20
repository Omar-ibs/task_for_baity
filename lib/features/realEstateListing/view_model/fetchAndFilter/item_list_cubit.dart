import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';
part 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemListState> {
  ItemListCubit(
    this.listingRepo,
    this.filterRepo,
  ) : super(ItemListInitial());

  final ListingRepo listingRepo;
  final FilterRepo filterRepo;

  Future<void> fetchItems() async {
    emit(ItemListLoading());
    final response = await listingRepo.fetchItems();

    response.fold(
      (failure) => emit(ItemListFailure(message: failure.errMessage)),
      (items) => emit(
        ItemListSuccess(
          itemsList: items,
          hasMore: items.isNotEmpty,
        ),
      ),
    );
  }

  Future<void> filterItems({
    required String offerType,
    required int pageSize,
    required int pageNumber,
    required String subCategoryId,
    required String cityId,
  }) async {
    emit(ItemListLoading());
    final filteredItems = await filterRepo.getFilteredResults(
      offerType: offerType,
      pageSize: pageSize,
      pageNumber: pageNumber,
      subCategoryId: subCategoryId,
      cityId: cityId,
    );

    filteredItems.fold(
      (failure) => emit(ItemListFailure(message: failure.errMessage)),
      (items) => emit(
        ItemListSuccess(itemsList: items, hasMore: items.length >= pageSize),
      ),
    );
  }

  /// Loads additional items for pagination.
  Future<void> loadMoreItems({
    required String offerType,
    required int pageSize,
    required int pageNumber,
    required String subCategoryId,
    required String cityId,
    List<RealEstate>? currentItems,
  }) async {
    if (state is! ItemListSuccess) {
      emit(ItemListFailure(message: "Cannot load more items in current state"));
      return;
    }

    final filteredItems = await filterRepo.getFilteredResults(
      offerType: offerType,
      pageSize: pageSize,
      pageNumber: pageNumber,
      subCategoryId: subCategoryId,
      cityId: cityId,
    );

    filteredItems.fold(
      (failure) => emit(ItemListFailure(message: failure.errMessage)),
      (newItems) {
        final updatedItems = [
          if (currentItems != null) ...currentItems,
          ...newItems
        ];
        emit(
          ItemListSuccess(
            itemsList: updatedItems,
            hasMore: newItems.length >= pageSize,
          ),
        );
      },
    );
  }
}
