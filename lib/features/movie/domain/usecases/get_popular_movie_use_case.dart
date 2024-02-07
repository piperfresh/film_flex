
import 'package:filmflex/features/movie/domain/entities/movie_entity.dart';
import 'package:filmflex/features/movie/domain/repository/movie_repository.dart';
import 'package:filmflex/features/movie/domain/usecases/use_case.dart';

class GetPopularMovieUseCase
    implements UseCase<List<MovieEntity>, void> {
  final MovieRepository _movieRepository;

  GetPopularMovieUseCase(this._movieRepository);

  @override
  Future<List<MovieEntity>> call({params}) {
    return _movieRepository.getPopularMovie();
  }
}
