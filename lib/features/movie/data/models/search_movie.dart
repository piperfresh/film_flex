import 'package:filmflex/features/movie/domain/entities/search_movie_entity.dart';

class SearchMovie extends SearchMovieEntity {
  SearchMovie({
    super.id,
    super.name,
  });

  SearchMovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}