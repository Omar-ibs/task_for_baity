part of 'categories_i_ds_fetching_cubit.dart';

sealed class CategoriesIDsFetchingState {}

final class CategoriesIDsFetchingLoading extends CategoriesIDsFetchingState {}

final class CategoriesIDsFetchingSuccess extends CategoriesIDsFetchingState {
  final List<Category> categories;

  CategoriesIDsFetchingSuccess({required this.categories});
}

final class CategoriesIDsFetchingFailed extends CategoriesIDsFetchingState {
  final String errorMessage;

  CategoriesIDsFetchingFailed({required this.errorMessage});
}
