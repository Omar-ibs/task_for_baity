import 'package:dartz/dartz.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

abstract class ListingRepo {
  Future<Either<Failure, List<RealEstate>>> fetchItems();
}
