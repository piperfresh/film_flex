import 'package:filmflex/features/movie/domain/entities/movie_cast_entity.dart';

class MovieCast extends MovieCastEntity {
  MovieCast({
    super.adult,
    super.gender,
    super.id,
    super.knownForDepartment,
    super.name,
    super.originalName,
    super.popularity,
    super.profilePath,
    super.castId,
    super.character,
    super.creditId,
    super.order,
  });

  MovieCast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    return data;
  }

  factory MovieCast.fromEntity(MovieCastEntity movieCastEntity) {
    return MovieCast(
      adult: movieCastEntity.adult,
      id: movieCastEntity.id,
      castId: movieCastEntity.castId,
      character: movieCastEntity.character,
      creditId: movieCastEntity.creditId,
      gender: movieCastEntity.gender,
      knownForDepartment: movieCastEntity.knownForDepartment,
      name: movieCastEntity.name,
      order: movieCastEntity.order,
      originalName: movieCastEntity.originalName,
      popularity: movieCastEntity.popularity,
      profilePath: movieCastEntity.profilePath,
    );
  }
}