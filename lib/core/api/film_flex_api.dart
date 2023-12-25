import 'package:dio/dio.dart';
import 'package:filmflex/constant/app_string.dart';
import 'package:filmflex/core/api/api_utils.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:filmflex/model/popular_movie_cast.dart';
import 'package:filmflex/services/message_service/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';

import 'api_response.dart';

class FilmFlexApi {
  final logger = SimpleLogger();
  String baseUrl = "https://api.themoviedb.org/3/";
  String apiKey = "719c821ece3dffc5e63e38956968f693";
  final dio = Dio();
  String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MTljODIxZWNlM2RmZmM1ZTYzZTM4OTU2OTY4ZjY5MyIsInN1YiI6IjY1ODJmOWRiODgwNTUxNDA5ZDI3OTQ3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t5WJkD3_FYPDRcpw0riZlP0upGU6ystCNMIErDfJphQ";

  //? Get Methods
  Future<ApiResponse?> get(
    String string, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
        BuildContext? context,
      }) async {
    logger.info('Making get request to $baseUrl$string');
    try {
      final response = await dio.get(
        '$baseUrl$string',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
      logger.info('Get response from $string \n ${response.data}');
      logger.info('$baseUrl$string');
      logger.info('This is the $queryParameters');
      print('Wow: ${response.requestOptions.uri}');
      if (response.statusCode == 200) {
        logger.severe('Received  response: ${response.statusCode}');
        logger.severe('Received  response: ${response.statusMessage}');
        return ApiUtils.toApiResponse(response);
      } else {
        print('Wow: ${response.requestOptions.uri}');
        logger.severe('Unsuccessful status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout) {
        SnackBarService.errorSnackBar(context!, 'Connection error or Receive timeout');
        logger.severe('Connection error or Receive timeout');
      } else if (e.response != null) {
        print('Wow: ${e.response?.requestOptions.uri}');
        logger.severe('Received error response: ${e.response!.statusCode}');
        logger.severe('Received error response: ${e.response!.statusMessage}');
      } else {
        logger.severe('Error: ${e.message}');
      }
      return null;
    }
  }

  Future<ApiResponse?> post(
    String string, {
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    logger.info('Making post request to ${baseUrl}$string');
    try {
      final response = await dio.post('$baseUrl$string',
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameter);
      logger.info('Post response to $string \n ${response.data}');

      return ApiUtils.toApiResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        logger.severe('Connection error');
      }
      return null;
    }
  }

  // Future<ApiResponse?> getMovies() async {
  // Future<MovieList> getMovies() async {
  //   final response = await get(
  //     AppString.movieListEndPoint,
  //     headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $accessToken'
  //     },
  //     queryParameters: {
  //       'page': 1,
  //     },
  //   );
  //   final res = MovieList.fromJson(response?.data);
  //   // return response;
  //   return res;
  // }


  Future<List<Movie>> getPopularMovie(BuildContext? context) async {
    final response = await get(
      AppString.popularMoviesEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      context: context,
    );
    // final res = PopularMovie.fromJson(response?.data['results']);
    if (response?.data['results'] != null) {
      final a = <Movie>[];
      response?.data['results'].forEach((v) {
        a.add(Movie.fromJson(v));
      });
      return a;
    } else {
      return [];
    }
  }

  Future<List<PopularMovieCast>> getPopularMoviesCast(
      BuildContext? context, String id) async {
    final response = await get(
      "${AppString.popularMoviesCastEndPoint}/$id/credits",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      context: context,
    );
    if (response?.data['cast'] != null) {
      final casts = <PopularMovieCast>[];
      response?.data['cast'].forEach((cast) {
        casts.add(PopularMovieCast.fromJson(cast));
      });
      return casts;
    } else {
      return [];
    }
  }

  Future<List<Movie>> getNowPlayingMovies(BuildContext? context) async {
    final response = await get(
      AppString.nowPlayingEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      context: context,
    );
    if (response?.data['results'] != null) {
      final nowPlayings = <Movie>[];
      response?.data['results'].forEach((nowPlaying) {
        nowPlayings.add(Movie.fromJson(nowPlaying));
      });
      return nowPlayings;
    } else {
      return [];
    }
  }
}
