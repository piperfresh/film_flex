
import 'package:filmflex/core/api/film_flex_api.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/src/screen/popular_movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constant/app_style.dart';
import '../common_widget/more_movie_tile.dart';

class MoreUpcomingMovieScreen extends StatelessWidget {
  MoreUpcomingMovieScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(
            'Back2'.svg,
            fit: BoxFit.scaleDown,
          ).paddingOnly(leftPadding: 0.0),
        ),
        title: Text(
          'Upcoming Movies',
          style: AppStyle.bigMullish,
        ),
        actions: [
          const Icon(Icons.menu).paddingOnly(rightPadding: 10.0),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: filmFlexApi.getUpcomingMovies(context),
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
                            context.push(PopularMovieDetail(popularMovie: movie), context);
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
