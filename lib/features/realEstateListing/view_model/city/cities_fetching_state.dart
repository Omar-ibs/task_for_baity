part of 'cities_fetching_cubit.dart';

sealed class CitiesFetchingState {}

final class CitiesFetchingLoading extends CitiesFetchingState {}

final class CitiesFetchingSuccess extends CitiesFetchingState {
  final List<Cities> cities;

  CitiesFetchingSuccess({required this.cities});
}

final class CitiesFetchingFailure extends CitiesFetchingState {
  final String errorMessage;

  CitiesFetchingFailure({required this.errorMessage});
}
