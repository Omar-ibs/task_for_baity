import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';

part 'cities_fetching_state.dart';

class CitiesFetchingCubit extends Cubit<CitiesFetchingState> {
  CitiesFetchingCubit(this.cityRepo) : super(CitiesFetchingLoading());
  final CityRepo cityRepo;
  Future<void> fetchCities() async {
    final response = await cityRepo.fetchCities();
    response.fold(
      (failure) =>
          emit(CitiesFetchingFailure(errorMessage: failure.errMessage)),
      (cities) => emit(
        CitiesFetchingSuccess(cities: cities),
      ),
    );
  }
}
