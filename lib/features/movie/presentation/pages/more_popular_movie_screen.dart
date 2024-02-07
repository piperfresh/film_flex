
import 'package:filmflex/core/api/film_flex_api.dart';
import 'package:filmflex/core/extensions/extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../widgets/more_movie_tile.dart';
import 'screen.dart';

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
          child: SvgPicture.asset(
            'Back2'.svg,
            fit: BoxFit.scaleDown,
          ).paddingOnly(leftPadding: 0.0),
        ),
        title: Text(
          'Popular Movies',
          // style: AppStyle.bigMullish,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions:  [
          const Icon(Icons.menu).paddingOnly(rightPadding: 10.0),
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
