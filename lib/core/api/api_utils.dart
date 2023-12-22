import 'package:dio/dio.dart';
import 'package:filmflex/core/api/api_response.dart';

class ApiUtils {
  static ApiResponse toApiResponse(Response res) {
    Map<String, dynamic> headers = Map<String, dynamic>.from(res.headers.map);
    return ApiResponse(
      data: res.data,
      statusCode: res.statusCode,
      headers: headers,
    );
  }
}
