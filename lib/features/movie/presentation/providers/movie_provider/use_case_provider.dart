import 'package:filmflex/features/movie/presentation/providers/movie_provider/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/fetch_movies_use_case.dart';
import '../../../domain/usecases/get_movie_cast_use_case.dart';
import '../../../domain/usecases/get_now_playing_use_case.dart';
import '../../../domain/usecases/get_popular_movie_use_case.dart';
import '../../../domain/usecases/get_upcoming_movies_use_case.dart';

final fetchMovieUseCaseProvider = Provider<FetchMovieUseCase>(
  (ref) => FetchMovieUseCase(ref.read(movieRepositoryProvider)),
);

final getNowPlayingUseCaseProvider = Provider<GetNowPlayingUseCase>(
  (ref) => GetNowPlayingUseCase(ref.read(movieRepositoryProvider)),
);

final getPopularMovieUseCaseProvider = Provider<GetPopularMovieUseCase>(
  (ref) => GetPopularMovieUseCase(ref.read(movieRepositoryProvider)),
);

final getMovieCastUseCaseProvider = Provider<GetMovieCastUseCase>(
  (ref) => GetMovieCastUseCase(ref.read(movieRepositoryProvider)),
);

final getUpcomingMoviesUseCaseProvider = Provider<GetUpcomingMoviesUseCase>(
  (ref) => GetUpcomingMoviesUseCase(ref.read(movieRepositoryProvider)),
);
