import 'dart:developer';

import 'package:dio/dio.dart';

import '../../constant/app_string.dart';
import '../api_response.dart';
import '../api_utils.dart';

// abstract class ApiProviderRepository<T> {
//   Future<T?> get(
//     String string, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//     String? token,
//     // BuildContext? context,
//   }) async {
//     return null;
//   }
//
//   Future<T?> post(
//     String string, {
//     Map<String, dynamic>? queryParameter,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//     String? token,
//   }) async {
//     return null;
//   }
// }


// class ApiProviderRepositoryImpl implements ApiProviderRepository<ApiResponse> {
//   final dio = Dio();
//
//   @override
//   Future<ApiResponse?> get(String string,
//       {Map<String, dynamic>? queryParameters,
//       Map<String, dynamic>? body,
//       Map<String, dynamic>? headers,
//       String? token}) async {
//     log('Making get request to $baseUrl$string');
//     try {
//       final response = await dio.get(
//         '$baseUrl$string',
//         queryParameters: queryParameters,
//         data: body,
//         options: Options(headers: headers),
//       );
//       log('Get response from $string \n ${response.data}');
//       log('$baseUrl$string');
//       log('This is the $queryParameters');
//       if (response.statusCode == 200) {
//         log('Received  response: ${response.statusCode}');
//         log('Received  response: ${response.statusMessage}');
//         return ApiUtils.toApiResponse(response);
//       } else {
//         log('Unsuccessful status code: ${response.statusCode}');
//         return null;
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError ||
//           e.type == DioExceptionType.receiveTimeout) {
//         // SnackBarService.errorSnackBar(context!, 'Connection error or Receive timeout');
//         // logger.severe('Connection error or Receive timeout');
//       } else if (e.response != null) {
//         print('Wow: ${e.response?.requestOptions.uri}');
//         log('Received error response: ${e.response!.statusCode}');
//         log('Received error response: ${e.response!.statusMessage}');
//       } else {
//         log('Error: ${e.message}');
//       }
//       return null;
//     }
//   }
//
//   @override
//   Future<ApiResponse?> post(
//     String string, {
//     Map<String, dynamic>? queryParameter,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//     String? token,
//   }) async {
//     log('Making post request to $baseUrl$string');
//     try {
//       final response = await dio.post('$baseUrl$string',
//           data: body,
//           options: Options(headers: headers),
//           queryParameters: queryParameter);
//       log('Post response to $string \n ${response.data}');
//
//       return ApiUtils.toApiResponse(response);
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError) {
//         log('Connection error');
//       }
//       return null;
//     }
//   }
// }
