import 'package:filmflex/constant/constants.dart';
import 'package:filmflex/core/api/film_flex_api.dart';
import 'package:filmflex/src/screen/popular_movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common_widget/more_movie_tile.dart';

class MorePopularMovieScreen extends StatelessWidget {
  MorePopularMovieScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: SvgPicture.asset(
              'assets/icons/Back2.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        title: Text(
          'Popular Movies',
          style: AppStyle.bigMullish,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: filmFlexApi.getPopularMovie(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                final data = snapshot.data;
                return Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PopularMovieDetail(popularMovie: movie);
                            }));
                          },
                          child: MoreMovieTile(movie: movie));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
