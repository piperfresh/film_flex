import 'package:filmflex/core/extensions.dart';
import 'package:filmflex/src/common_widget/now_playing_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'screen.dart';

import '../../constant/app_style.dart';
import '../../core/api/film_flex_api.dart';
import '../common_widget/common_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    filmFlexApi.fetchMovies(context, 'merlin');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'Menu'.svg,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Film Flix',
          style: AppStyle.mediumMerriWeather,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(SearchScreen(), context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                'search_icon'.svg,
                height: 20.h,
                width: 20.h,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'Notif'.svg,
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
                padding: EdgeInsets.all(16.0.w),
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
                      onPressed: () {
                        context.push(MoreNowShowingMovieScreen(), context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: FutureBuilder(
                  future: filmFlexApi.getNowPlayingMovies(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 320.h,
                        child: const Center(
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
                        height: 280.h,
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
                            return SizedBox(
                              width: 16.w,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0.w, bottom: 16.0.h, right: 16.0.w),
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
                      onPressed: () {
                        context.push(MorePopularMovieScreen(), context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: FutureBuilder(
                  future: filmFlexApi.getPopularMovie(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 320.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      final movieList = snapshot.data;
                      return SizedBox(
                        height: 320.h,
                        child: ListView.separated(
                          itemCount: movieList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final popularMovie = movieList[index];
                            return MovieTile(
                              isPopular: true,
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0.w, bottom: 16.0.h, right: 16.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Upcoming',
                      style: AppStyle.mediumMerriWeather,
                    ),
                    ActionButton(
                      text: 'See more',
                      onPressed: () {
                        context.push(MoreUpcomingMovieScreen(), context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: FutureBuilder(
                  future: filmFlexApi.getUpcomingMovies(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 320.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      final upcomingMovies = snapshot.data;
                      return SizedBox(
                        height: 320.h,
                        child: ListView.separated(
                          itemCount: upcomingMovies!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final upcomingMovie = upcomingMovies[index];
                            return MovieTile(
                              movie: upcomingMovie,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}