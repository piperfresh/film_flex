import 'package:filmflex/features/movie/domain/entities/movie_entity.dart';

class Movie extends MovieEntity {
  Movie(
      {bool? adult,
      String? backdropPath,
      int? id,
      List<int>? genreIds,
      String? originalLanguage,
      String? originalTitle,
      String? overview,
      double? popularity,
      String? posterPath,
      String? releaseDate,
      String? title,
      bool? video,
      double? voteAverage,
      int? voteCount})
      : super(
          adult: adult,
          title: title,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          id: id,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          backdropPath: backdropPath,
          genreIds: genreIds,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  // bool? adult;
  // String? backdropPath;
  // List<int>? genreIds;
  // int? id;
  // String? originalLanguage;
  // String? originalTitle;
  // String? overview;
  // double? popularity;
  // String? posterPath;
  // String? releaseDate;
  // String? title;
  // bool? video;
  // double? voteAverage;
  // int? voteCount;

  // Movie({this.adult,
  //   this.backdropPath,
  //   this.genreIds,
  //   this.id,
  //   this.originalLanguage,
  //   this.originalTitle,
  //   this.overview,
  //   this.popularity,
  //   this.posterPath,
  //   this.releaseDate,
  //   this.title,
  //   this.video,
  //   this.voteAverage,
  //   this.voteCount});


  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  factory Movie.fromEntity(MovieEntity entity) {
    return Movie(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}

// class Movie {
//   bool? adult;
//   String? backdropPath;
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? firstAirDate;
//   String? title;
//   bool? video;
//   double? voteAverage;
//   int? voteCount;
//   String? originalName;
//   List? originCountry;
//
//
//   Movie({this.adult,
//     this.backdropPath,
//     this.genreIds,
//     this.id,
//     this.originalLanguage,
//     this.originalName,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.originCountry,
//     this.firstAirDate,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount});
//
//   Movie.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     backdropPath = json['backdrop_path'];
//     genreIds = json['genre_ids'].cast<int>();
//     id = json['id'];
//     originalLanguage = json['original_language'];
//     originalTitle = json['original_title'];
//     originalName = json['original_name'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     posterPath = json['poster_path'];
//     releaseDate = json['release_date'];
//     originCountry = json['origin_country'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//     firstAirDate = json['first_air_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['adult'] = adult;
//     data['backdrop_path'] = backdropPath;
//     data['genre_ids'] = genreIds;
//     data['id'] = id;
//     data['original_language'] = originalLanguage;
//     data['original_title'] = originalTitle;
//     data['overview'] = overview;
//     data['popularity'] = popularity;
//     data['poster_path'] = posterPath;
//     data['release_date'] = releaseDate;
//     data['title'] = title;
//     data['video'] = video;
//     data['vote_average'] = voteAverage;
//     data['vote_count'] = voteCount;
//     return data;
//   }
// }