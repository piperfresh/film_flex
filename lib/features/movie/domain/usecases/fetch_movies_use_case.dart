import 'package:filmflex/features/movie/domain/entities/movie_entity.dart';
import 'package:filmflex/features/movie/domain/repository/movie_repository.dart';
import 'package:filmflex/features/movie/domain/usecases/use_case.dart';

class FetchMovieUseCase
    implements UseCase<List<MovieEntity>, String> {
  final MovieRepository _movieRepository;

  FetchMovieUseCase(this._movieRepository);

  @override
  Future<List<MovieEntity>> call({String? params}) {
    return _movieRepository.fetchMovies(params ?? '');
  }
}
