import 'package:dio/dio.dart';
import 'package:filmflex/core/resources/data_state.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:filmflex/features/movie/data/models/popular_movie_cast.dart';
import 'package:filmflex/features/movie/domain/repository/movie_repository.dart';

import '../../../../core/constant/app_string.dart';
import '../data_source/remote/film_flex_api_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final ApiProviderRepositoryImpl _apiProviderRepository =
      ApiProviderRepositoryImpl();

  @override
  Future<List<Movie>> fetchMovies(String query) async {
    final response = await _apiProviderRepository.get(
      AppString.searchMovieEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey, 'query': query, 'page': 1},
      // context: context,
    );
    if (response?.data['results'] != null) {
      final searchDetails = <Movie>[];
      response?.data['results'].forEach((searchMovie) {
        searchDetails.add(Movie.fromJson(searchMovie));
      });
      return searchDetails;
    } else {
      return [];
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _apiProviderRepository.get(
      AppString.nowPlayingEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      // context: context,
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

  @override
  Future<List<Movie>> getPopularMovie() async {
    final response = await _apiProviderRepository.get(
      AppString.popularMoviesEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      // context: context,
    );
    if (response?.data['results'] != null) {
      final movieList = <Movie>[];
      response?.data['results'].forEach((v) {
        movieList.add(Movie.fromJson(v));
      });
      return movieList;
    } else {
      return [];
    }
  }

  @override
  Future<List<PopularMovieCast>> getPopularMoviesCast(String id) async {
    final response = await _apiProviderRepository.get(
      "${AppString.popularMoviesCastEndPoint}/$id/credits",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      // context: context,
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

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await _apiProviderRepository.get(
      AppString.upcomingEndPoint,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      queryParameters: {'api_key': apiKey},
      // context: context,
    );
    if (response?.data['results'] != null) {
      final upcomingMovies = <Movie>[];
      response?.data['results'].forEach((upcomingMovie) {
        upcomingMovies.add(Movie.fromJson(upcomingMovie));
      });
      return upcomingMovies;
    } else {
      return [];
    }
  }

// final ApiProviderRepositoryImpl _apiProviderRepository =
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
}