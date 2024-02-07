import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:filmflex/core/api/flim_flex_api/api_service_repository.dart';
// import 'package:filmflex/core/resources/data_state.dart';
import 'package:filmflex/features/movie/data/data_source/remote/film_flex_api_data_source.dart';

// import 'package:filmflex/features/movie/data/models/movie_list.dart';
// import 'package:filmflex/features/movie/data/models/popular_movie_cast.dart';

import '../../../../../core/api/api_response.dart';
import '../../../../../core/api/api_utils.dart';
import '../../../../../core/constant/app_string.dart';

// class FilmFlexApiDataSource implements FilmFlexApiService {
//   final ApiProviderRepositoryImpl _apiProviderRepository =
//       ApiProviderRepositoryImpl();
//
//   @override
//   Future<DataState<List<Movie>>> fetchMovies(String query) async {
//     final response = await _apiProviderRepository.get(
//       AppString.searchMovieEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey, 'query': query, 'page': 1},
//       // context: context,
//     );
//     if (response?.data['results'] != null) {
//       final searchDetails = <Movie>[];
//       response?.data['results'].forEach((searchMovie) {
//         searchDetails.add(Movie.fromJson(searchMovie));
//       });
//       return DataSuccess(searchDetails);
//     } else {
//       return DataFailure(DioException(requestOptions: RequestOptions()));
//     }
//   }
//
//   @override
//   Future<DataState<List<Movie>>> getNowPlayingMovies() async {
//     final response = await _apiProviderRepository.get(
//       AppString.nowPlayingEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       // context: context,
//     );
//     if (response?.data['results'] != null) {
//       final nowPlayings = <Movie>[];
//       response?.data['results'].forEach((nowPlaying) {
//         nowPlayings.add(Movie.fromJson(nowPlaying));
//       });
//       return DataSuccess(nowPlayings);
//     } else {
//       return DataFailure(error);
//     }
//   }
//
//   @override
//   Future<List<Movie>> getPopularMovie() async {
//     final response = await _apiProviderRepository.get(
//       AppString.popularMoviesEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       // context: context,
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
//   @override
//   Future<List<PopularMovieCast>> getPopularMoviesCast(String id) async {
//     final response = await _apiProviderRepository.get(
//       "${AppString.popularMoviesCastEndPoint}/$id/credits",
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       // context: context,
//     );
//     if (response?.data['cast'] != null) {
//       final casts = <PopularMovieCast>[];
//       response?.data['cast'].forEach((cast) {
//         casts.add(PopularMovieCast.fromJson(cast));
//       });
//       return casts;
//     } else {
//       return [];
//     }
//   }
//
//   @override
//   Future<List<Movie>> getUpcomingMovies() async {
//     final response = await _apiProviderRepository.get(
//       AppString.upcomingEndPoint,
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken'
//       },
//       queryParameters: {'api_key': apiKey},
//       // context: context,
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
// }

// class ApiProviderRepositoryImpl implements ApiProviderRepository<ApiResponse> {
class ApiProviderRepositoryImpl implements ApiProviderRepository<ApiResponse> {
  final dio = Dio();

  @override
  Future<ApiResponse?> get(String string,
      {Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token}) async {
    log('Making get request to $baseUrl$string');
    try {
      final response = await dio.get(
        '$baseUrl$string',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
      log('Get response from $string \n ${response.data}');
      log('$baseUrl$string');
      log('This is the $queryParameters');
      if (response.statusCode == 200) {
        log('Received  response: ${response.statusCode}');
        log('Received  response: ${response.statusMessage}');
        return ApiUtils.toApiResponse(response);
      } else {
        log('Unsuccessful status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout) {
        // SnackBarService.errorSnackBar(context!, 'Connection error or Receive timeout');
        log('Connection error or Receive timeout');
        // DataFailure(e);
        print('Error : $e');
      } else if (e.response != null) {
        print('Wow: ${e.response?.requestOptions.uri}');
        log('Received error response: ${e.response!.statusCode}');
        log('Received error response: ${e.response!.statusMessage}');
      } else {
        log('Error: ${e.message}');
      }
      return null;
    }
  }

  @override
  Future<ApiResponse?> post(
      String string, {
        Map<String, dynamic>? queryParameter,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
      }) async {
    log('Making post request to $baseUrl$string');
    try {
      final response = await dio.post('$baseUrl$string',
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameter);
      log('Post response to $string \n ${response.data}');
      print('IT IS HAAA $response');
      return ApiUtils.toApiResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        log('Connection error');
      }
      return null;
    }
  }
}
