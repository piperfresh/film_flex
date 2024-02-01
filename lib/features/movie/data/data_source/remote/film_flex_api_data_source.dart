import '../../models/movie_list.dart';
import '../../models/popular_movie_cast.dart';

// abstract class FilmFlexApiService{
//   Future<List<Movie>> getPopularMovie();
//   Future<List<PopularMovieCast>> getPopularMoviesCast(String id);
//   Future<List<Movie>> getNowPlayingMovies();
//   Future<List<Movie>> getUpcomingMovies();
//   Future<List<Movie>> fetchMovies(String query);
// }


abstract class ApiProviderRepository<T> {
  Future<T?> get(
      String string, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
        // BuildContext? context,
      }) async {
    return null;
  }

  Future<T?> post(
      String string, {
        Map<String, dynamic>? queryParameter,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
      }) async {
    return null;
  }
}