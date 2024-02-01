import 'package:filmflex/features/movie/domain/entities/movie_cast_entity.dart';
import 'package:filmflex/features/movie/domain/entities/movie_entity.dart';

import '../../../../core/resources/data_state.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getPopularMovie();

  Future<List<MovieCastEntity>> getPopularMoviesCast(String id);

  Future<List<MovieEntity>> getNowPlayingMovies();

  Future<List<MovieEntity>> getUpcomingMovies();

  Future<List<MovieEntity>> fetchMovies(String query);
}
