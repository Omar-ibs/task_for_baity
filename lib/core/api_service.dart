import 'package:dio/dio.dart';
import 'package:task_for_baity/core/error_handler.dart';

enum ApiEndpoint {
  realEstate,
  category,
  city,
}

extension ApiEndpointExtension on ApiEndpoint {
  String get url {
    switch (this) {
      case ApiEndpoint.realEstate:
        return "https://v3.ibaity.com/api/client/Realestate/";
      case ApiEndpoint.category:
        return "https://v3.ibaity.com/api/dashboard/Category";
      case ApiEndpoint.city:
        return "https://v3.ibaity.com/api/v1/dashboard/City";
    }
  }
}

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> get(
      String endpoint, Map<String, dynamic>? queryParams) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }
}
