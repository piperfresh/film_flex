import 'package:dio/dio.dart';
import 'package:filmflex/core/api/api_response.dart';

class ApiUtils {
  static ApiResponse toApiResponse(Response res) {
    return ApiResponse(
      data: res.data,
      statusCode: res.statusCode,
      headers: res.headers.map,
    );
  }
}
