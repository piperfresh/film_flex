import 'package:filmflex/features/movie/domain/entities/movie_cast_entity.dart';
import 'package:filmflex/features/movie/domain/repository/movie_repository.dart';
import 'package:filmflex/features/movie/domain/usecases/use_case.dart';

class GetMovieCastUseCase
    implements UseCase<List<MovieCastEntity>, String> {
  final MovieRepository _movieRepository;

  GetMovieCastUseCase(this._movieRepository);

  @override
  Future<List<MovieCastEntity>> call({String? params}) {
    return _movieRepository.getPopularMoviesCast(params ?? "");
  }
}
