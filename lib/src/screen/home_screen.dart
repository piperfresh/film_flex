import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/providers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_style.dart';
import '../../core/api/film_flex_api.dart';
import '../common_widget/common_widget.dart';
import 'screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    filmFlexApi.fetchMovies(context, 'merlin');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: SvgPicture.asset(
          'Menu'.svg,
          fit: BoxFit.scaleDown,
        ).paddingAll(8.0),
        title: Text(
          'Film Flix',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(SearchScreen(), context);
            },
            child: SvgPicture.asset(
              'search_icon'.svg,
              height: 20.h,
              width: 20.h,
              fit: BoxFit.scaleDown,
            ).paddingAll(5.0),
          ),
          Consumer(
            builder: (context, ref, child) =>
             GestureDetector(
              onTap: (){
                ref.watch(themeNotifierProvider.notifier).toggleTheme();
              },
              child: SvgPicture.asset(
                'mode'.svg,
                height: 20.h,
                width: 20.w,
                fit: BoxFit.scaleDown,
              ).paddingAll(8.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Now Showing',
                    // style: AppStyle.mediumMerriWeather,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  ActionButton(
                    text: 'See more',
                    onPressed: () {
                      context.push(MoreNowShowingMovieScreen(), context);
                    },
                  )
                ],
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  rightPadding: 5.0.w,
                  bottomPadding: 10.0.w),
              FutureBuilder(
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
              ).paddingOnly(leftPadding: 10.0.w, topPadding: 10.0.w, bottomPadding: 10.0.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Popular',
                    // style: AppStyle.mediumMerriWeather,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  ActionButton(
                    text: 'See more',
                    onPressed: () {
                      context.push(MorePopularMovieScreen(), context);
                    },
                  )
                ],
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  rightPadding: 5.0.w,
                  bottomPadding: 10.0.w),
              FutureBuilder(
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
              ).paddingOnly(leftPadding: 10.0.w, topPadding: 10.0.w, bottomPadding: 10.0.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Upcoming',
                    // style: AppStyle.mediumMerriWeather,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  ActionButton(
                    text: 'See more',
                    onPressed: () {
                      context.push(MoreUpcomingMovieScreen(), context);
                    },
                  )
                ],
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  rightPadding: 5.0.w,
                  bottomPadding: 10.0.w),
              FutureBuilder(
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
              ).paddingOnly(leftPadding: 10.0.w, topPadding: 10.0.w, bottomPadding: 10.0.w),
            ],
          ),
        ),
      ),
    );
  }
}