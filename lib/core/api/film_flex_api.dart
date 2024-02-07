// import 'package:dio/dio.dart';
// import 'package:filmflex/core/api/api_utils.dart';
// import 'package:filmflex/features/movie/data/models/movie_list.dart';
// import 'package:filmflex/features/movie/data/models/popular_movie_cast.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_logger/simple_logger.dart';
//
// import '../constant/constants.dart';
// import '../services/message_service/snack_bar_service.dart';
// import 'api_response.dart';
//
// class FilmFlexApi {
//   final logger = SimpleLogger();
//
//
//   final dio = Dio();
//
//
//   //? Get Methods
//   Future<ApiResponse?> get(
//     String string, {
//         Map<String, dynamic>? queryParameters,
//         Map<String, dynamic>? body,
//         Map<String, dynamic>? headers,
//         String? token,
//         BuildContext? context,
//       }) async {
//     logger.info('Making get request to $baseUrl$string');
//     try {
//       final response = await dio.get(
//         '$baseUrl$string',
//         queryParameters: queryParameters,
//         data: body,
//         options: Options(headers: headers),
//       );
//       logger.info('Get response from $string \n ${response.data}');
//       logger.info('$baseUrl$string');
//       logger.info('This is the $queryParameters');
//       if (response.statusCode == 200) {
//         logger.info('Received  response: ${response.statusCode}');
//         logger.info('Received  response: ${response.statusMessage}');
//         return ApiUtils.toApiResponse(response);
//       } else {
//         logger.severe('Unsuccessful status code: ${response.statusCode}');
//         return null;
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError ||
//           e.type == DioExceptionType.receiveTimeout) {
//         SnackBarService.errorSnackBar(context!, 'Connection error or Receive timeout');
//         logger.severe('Connection error or Receive timeout');
//       } else if (e.response != null) {
//         print('Wow: ${e.response?.requestOptions.uri}');
//         logger.severe('Received error response: ${e.response!.statusCode}');
//         logger.severe('Received error response: ${e.response!.statusMessage}');
//       } else {
//         logger.severe('Error: ${e.message}');
//       }
//       return null;
//     }
//   }
//
//   Future<ApiResponse?> post(
//     String string, {
//     Map<String, dynamic>? queryParameter,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//     String? token,
//   }) async {
//     logger.info('Making post request to ${baseUrl}$string');
//     try {
//       final response = await dio.post('$baseUrl$string',
//           data: body,
//           options: Options(headers: headers),
//           queryParameters: queryParameter);
//       logger.info('Post response to $string \n ${response.data}');
//
//       return ApiUtils.toApiResponse(response);
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError) {
//         logger.severe('Connection error');
//       }
//       return null;
//     }
//   }
//
//
//
//   Future<List<Movie>> getPopularMovie(BuildContext? context) async {
//     final response = await get(
//       AppString.popularMoviesEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       context: context,
//     );
//     if (response?.data['results'] != null) {
//       final movieList = <Movie>[];
//       response?.data['results'].forEach((v) {
//         movieList.add(Movie.fromJson(v));
//       });
//       return movieList;
//     } else {
//       return [];
//     }
//   }
//
//   Future<List<MovieCast>> getPopularMoviesCast(
//       BuildContext? context, String id) async {
//     final response = await get(
//       "${AppString.popularMoviesCastEndPoint}/$id/credits",
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       context: context,
//     );
//     if (response?.data['cast'] != null) {
//       final casts = <MovieCast>[];
//       response?.data['cast'].forEach((cast) {
//         casts.add(MovieCast.fromJson(cast));
//       });
//       return casts;
//     } else {
//       return [];
//     }
//   }
//
//   Future<List<Movie>> getNowPlayingMovies(BuildContext? context) async {
//     final response = await get(
//       AppString.nowPlayingEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       context: context,
//     );
//     if (response?.data['results'] != null) {
//       final nowPlayings = <Movie>[];
//       response?.data['results'].forEach((nowPlaying) {
//         nowPlayings.add(Movie.fromJson(nowPlaying));
//       });
//       return nowPlayings;
//     } else {
//       return [];
//     }
//   }
//
//   Future<List<Movie>> getUpcomingMovies(BuildContext? context) async {
//     final response = await get(
//       AppString.upcomingEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       context: context,
//     );
//     if (response?.data['results'] != null) {
//       final upcomingMovies = <Movie>[];
//       response?.data['results'].forEach((upcomingMovie) {
//         upcomingMovies.add(Movie.fromJson(upcomingMovie));
//       });
//       return upcomingMovies;
//     } else {
//       return [];
//     }
//   }
//
//   Future<List<Movie>> fetchMovies(
//       BuildContext? context, String? query) async {
//     final response = await get(
//       AppString.searchMovieEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey, 'query': query, 'page': 1},
//       context: context,
//     );
//     if (response?.data['results'] != null) {
//       final searchDetails = <Movie>[];
//       response?.data['results'].forEach((searchMovie) {
//         searchDetails.add(Movie.fromJson(searchMovie));
//       });
//       return searchDetails;
//     } else {
//       return [];
//     }
//   }
// }
