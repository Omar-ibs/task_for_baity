import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';

part 'categories_i_ds_fetching_state.dart';

class CategoriesIDsFetchingCubit extends Cubit<CategoriesIDsFetchingState> {
  CategoriesIDsFetchingCubit(this.categoryRepo)
      : super(CategoriesIDsFetchingLoading());
  final CategoryRepo categoryRepo;
  Future<void> fetchCategories() async {
    emit(CategoriesIDsFetchingLoading());
    final response = await categoryRepo.fetchCategories();
    response.fold(
      (failure) =>
          emit(CategoriesIDsFetchingFailed(errorMessage: failure.errMessage)),
      (categories) => emit(
        CategoriesIDsFetchingSuccess(categories: categories),
      ),
    );
  }
}
