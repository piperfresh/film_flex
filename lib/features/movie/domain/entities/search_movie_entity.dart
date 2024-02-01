import 'package:equatable/equatable.dart';

class SearchMovieEntity extends Equatable {
  int? id;
  String? name;

  SearchMovieEntity({this.id, this.name});

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
