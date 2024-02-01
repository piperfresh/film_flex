import 'package:filmflex/features/movie/domain/repository/movie_repository.dart';
import 'package:filmflex/features/movie/domain/usecases/fetch_movies_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../data/repository/movie_repository_impl.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_now_playing_use_case.dart';

// abstract class FilmFlexState extends Equatable {
//   final List<Movie>? movies;
//   final DioException? error;
//   final List<PopularMovieCast>? moviesCast;
//
//   const FilmFlexState({
//     this.movies,
//     this.error,
//     this.moviesCast,
//   });
//
//   @override
//   List<Object?> get props => [movies, error];
// }
//
// class MovieLoading extends FilmFlexState {
//   const MovieLoading();
// }
//
// class MovieDone extends FilmFlexState {
//   const MovieDone({super.movies, super.moviesCast});
// }
//
// class MovieError extends FilmFlexState {
//   const MovieError({super.error});
// }
//
// // final filmFlexStateProvider = StateNotifierProvider<FilmFlexState, MovieNotifier>((ref) => null);
//
// Future<void> getMovies() async {
//
// }

final movieRepositoryProvider = Provider<MovieRepository>((ref){
  return MovieRepositoryImpl();
});

final fetchMovieUseCaseProvider = Provider<FetchMovieUseCase>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return FetchMovieUseCase(movieRepository);
});

final fetchMovieProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final fetchMovieUseCase = ref.read(fetchMovieUseCaseProvider);
  final result = await fetchMovieUseCase.call(params: 'your_query_here');
  return result ; // Assuming DataState has a data property
});

final getNowPlayingUseCaseProvider = Provider<GetNowPlayingUseCase>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return GetNowPlayingUseCase(movieRepository);
});

final getNowPlayingProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final getNowPlayingUseCase = ref.read(getNowPlayingUseCaseProvider);
  final result = await getNowPlayingUseCase.call();
  return result;
});