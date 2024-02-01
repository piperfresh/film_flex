import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/movie/data/models/movie_list.dart';
import 'common_widget.dart';

class FilmFlexFutureBuilder extends StatelessWidget {
  Future<List<Movie>>? future;
  double? height;
  List<Movie>? movieList;
  bool isPopular;
  double? height2;

  FilmFlexFutureBuilder(
      {super.key,
      this.future,
      this.height,
      this.isPopular = false,
      this.movieList,
      this.height2});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          movieList = snapshot.data;
          return SizedBox(
            height: height2,
            child: ListView.separated(
              itemCount: movieList!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final popularMovie = movieList![index];
                return MovieTile(
                  isPopular: isPopular,
                  movie: popularMovie,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 16.w,
                );
              },
            ),
          );
        }
      },
    );
  }
}
