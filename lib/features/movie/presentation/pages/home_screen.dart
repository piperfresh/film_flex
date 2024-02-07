import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/core/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


import '../providers/movie_provider/ui_provider.dart';
import '../widgets/common_widget.dart';
import 'screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  // final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final popularMovies = ref.watch(popularMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SvgPicture.asset(
          'Menu'.svg,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(Theme.of(context).textTheme.displayLarge!.color!, BlendMode.srcIn),
        ).paddingAll(8.0),
        title: Text(
          'Film Flix',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(const SearchScreen(), context);
            },
            child: SvgPicture.asset(
              'search_icon'.svg,
              height: 18.h,
              width: 18.h,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(Theme.of(context).textTheme.displayLarge!.color!, BlendMode.srcIn),
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
                    height: 18.h,
                    width: 18.w,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(Theme.of(context).textTheme.displayLarge!.color!, BlendMode.srcIn),
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
              ),
              nowPlayingMovies
                  .when(
                    data: (nowPlayingMovies) {
                      return SizedBox(
                        height: 290.h,
                        child: ListView.separated(
                          itemCount: nowPlayingMovies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final popularMovie = nowPlayingMovies[index];
                            return MovieTile(
                              isPopular: false,
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
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    },
                    loading: () => SizedBox(
                      height: 290.h,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                  .paddingOnly(
                    leftPadding: 10.0.w,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Popular',
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
              ),
              popularMovies
                  .when(
                    data: (popularMovies) {
                      return SizedBox(
                        height: 290.h,
                        child: ListView.separated(
                          itemCount: popularMovies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final popularMovie = popularMovies[index];
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
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    },
                    loading: () => SizedBox(
                      height: 290.h,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                  .paddingOnly(
                    leftPadding: 10.0.w,
                  ),
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
              ),
              upcomingMovies
                  .when(
                    data: (upcomingMovies) {
                      return SizedBox(
                        height: 290.h,
                        child: ListView.separated(
                          itemCount: upcomingMovies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final upcomingMovie = upcomingMovies[index];
                            return MovieTile(
                              isPopular: false,
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
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    },
                    loading: () => SizedBox(
                      height: 290.h,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                  .paddingOnly(
                    leftPadding: 10.0.w,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

