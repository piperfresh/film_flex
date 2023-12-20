import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';

import 'api_response.dart';

class FilmFlexApi {
  final logger = SimpleLogger();
  String baseUrl = "https://api.themoviedb.org/3/";
  final dio = Dio();

  //? Get Methods
  Future<ApiResponse?> get(
    String string, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$string',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        logger.severe('Connection error');
      }
      return null;
    }
  }
}
