import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = 'https://v3.ibaity.com/api/';

  Future<Map<String, dynamic>> get(
    String baseUrl,
    String endPoint,
    Map<String, dynamic>? queryParams,
  ) async {
    try {
      final response = await Dio().get(
        '$baseUrl$endPoint',
        queryParameters:
            queryParams, // This line handles query parameters properly
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
