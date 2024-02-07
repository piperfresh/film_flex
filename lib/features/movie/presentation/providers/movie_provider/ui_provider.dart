import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:filmflex/features/movie/data/models/popular_movie_cast.dart';
import 'package:filmflex/features/movie/presentation/providers/movie_provider/string_provider.dart';
import 'package:filmflex/features/movie/presentation/providers/movie_provider/use_case_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularMoviesProvider = FutureProvider<List<Movie>>(
  (ref) async {
    final movies = await ref.read(getPopularMovieUseCaseProvider).call();
    return movies.map((movieEntity) => Movie.fromEntity(movieEntity)).toList();
  },
);

final nowPlayingMoviesProvider = FutureProvider<List<Movie>>(
  (ref) async {
    final movies = await ref.read(getNowPlayingUseCaseProvider).call();
    return movies.map((movieEntity) => Movie.fromEntity(movieEntity)).toList();
  },
);

final movieCastProvider = FutureProvider<List<MovieCast>>((ref) async {
  final movieCastId = ref.watch(movieCastIdProvider);
  final movieCasts =
      await ref.read(getMovieCastUseCaseProvider).call(params: movieCastId);
  return movieCasts
      .map((movieCastEntity) => MovieCast.fromEntity(movieCastEntity))
      .toList();
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final movies = await ref.read(getUpcomingMoviesUseCaseProvider).call();
  return movies.map((movieEntity) => Movie.fromEntity(movieEntity)).toList();
});

final fetchMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final searchText = ref.watch(searchQueryProvider);
  final fetchedMovies =
      await ref.read(fetchMovieUseCaseProvider).call(params: searchText);
  return fetchedMovies
      .map((movieEntity) => Movie.fromEntity(movieEntity))
      .toList();
});
