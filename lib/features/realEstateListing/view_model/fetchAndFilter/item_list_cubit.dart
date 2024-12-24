import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';
part 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemListState> {
  ItemListCubit(
    this.listingRepo,
    this.filterRepo,
  ) : super(ItemListInitial());
  String? currentCityId;
  String? currentCategoryId;
  String? currentSubCategoryId;
  String currentOfferType = 'SELL';
  String currentCityName = 'Baghdad';
  int? currentPage;
  final ListingRepo listingRepo;
  final FilterRepo filterRepo;

  Future<void> fetchItems() async {
    emit(ItemListLoading());
    final response = await listingRepo.fetchItems();
    response.fold(
      (failure) => emit(ItemListFailure(message: failure.errMessage, null)),
      (items) => emit(
        ItemListSuccess(
          itemsList: items,
          hasMore: items.isNotEmpty,
          currentPage = 1,
        ),
      ),
    );
  }

  Future<void> filterItems({
    required String offerType,
    required int pageSize,
    required int pageNumber,
    required String categoryId,
    required String subCategoryId,
    required String cityId,
    required String cityName,
  }) async {
    currentOfferType = offerType;
    currentCityId = cityId;
    currentCategoryId = categoryId;
    currentSubCategoryId = subCategoryId;
    currentCityName = cityName;

    emit(ItemListLoading());
    final filteredItems = await filterRepo.getFilteredResults(
      offerType: offerType,
      subCategoryId: subCategoryId,
      cityId: cityId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    filteredItems.fold(
      (failure) => emit(ItemListFailure(message: failure.errMessage, null)),
      (items) => emit(
        ItemListSuccess(
            itemsList: items, hasMore: items.length >= pageSize, pageNumber),
      ),
    );
  }

  Future<void> loadMoreItems({
    required String offerType,
    required int pageSize,
    required String? subCategoryId,
    required String? cityId,
  }) async {
    final currentState = state as ItemListSuccess;
    final nextPage = currentPage! + 1;
    final response = await filterRepo.getFilteredResults(
      offerType: offerType,
      subCategoryId: subCategoryId ?? '',
      cityId: cityId ?? '',
      pageNumber: nextPage,
      pageSize: pageSize,
      forceRefresh: true,
    );
    response.fold(
      (failure) {
        emit(ItemListFailure(
          message: failure.errMessage,
          currentState.itemsList,
        ));
      },
      (newItems) {
        if (newItems.isNotEmpty) {
          final updatedItems = [
            ...currentState.itemsList,
            ...newItems.where((item) => !currentState.itemsList.contains(item)),
          ];
          emit(ItemListSuccess(
            itemsList: updatedItems,
            hasMore: newItems.length == pageSize,
            currentPage = nextPage,
          ));
        }
      },
    );
  }
}
