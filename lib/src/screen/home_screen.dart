import 'package:filmflex/src/common_widget/now_playing_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_style.dart';
import '../../core/api/film_flex_api.dart';
import '../common_widget/common_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    filmFlexApi.getPopularMoviesCast(context, '316005');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/Menu.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Film Flix',
          style: AppStyle.mediumMerriWeather,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/Notif.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Now Showing',
                      style: AppStyle.mediumMerriWeather,
                    ),
                    ActionButton(
                      text: 'See more',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FutureBuilder(
                  future: filmFlexApi.getNowPlayingMovies(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 320,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      final nowPlayings = snapshot.data;
                      return SizedBox(
                        height: 320,
                        child: ListView.separated(
                          itemCount: nowPlayings!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final popularMovie = nowPlayings[index];
                            return NowPlayingMovieTile(
                              popularMovie: popularMovie,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 16,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Popular',
                      style: AppStyle.mediumMerriWeather,
                    ),
                    ActionButton(
                      text: 'See more',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FutureBuilder(
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
                      final movieList = snapshot.data;
                      return SizedBox(
                        height: 320,
                        child: ListView.separated(
                          itemCount: movieList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final popularMovie = movieList[index];
                            return PopularMovieTile(
                              popularMovie: popularMovie,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 16,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
