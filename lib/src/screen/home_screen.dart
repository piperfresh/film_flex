import 'dart:developer';

import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/providers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/api/film_flex_api.dart';
import '../../features/movie/presentation/providers/movie_provider/flim_flex_state.dart';
import '../common_widget/common_widget.dart';
import '../common_widget/flim_flex_future_builder.dart';
import 'screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchMovieResult = ref.watch(fetchMovieProvider.future);
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
              context.push(const SearchScreen(), context);
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
              FilmFlexFutureBuilder(
                key: const Key('nowPlayingMovie'),
                height: 320.h,
                future: filmFlexApi.getNowPlayingMovies(context),
                height2: 280.h,
                // isPopular: true,
                // filmFlexApi: filmFlexApi
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  topPadding: 10.0.w,
                  bottomPadding: 10.0.w),

              // fetchMovieResult.when(
              //   data: (data) => SizedBox(
              //     height: 200,
              //     child: ListView.separated(
              //       itemCount: data.length,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         final popularMovie = data[index];
              //         log('IT IS HA ${popularMovie.id}');
              //         return MovieEntityTile(
              //           isPopular: true,
              //           movie: popularMovie,
              //         );
              //       },
              //       separatorBuilder: (BuildContext context, int index) {
              //         return SizedBox(
              //           width: 16.w,
              //         );
              //       },
              //     ),
              //   ),
              //   error: (error, stackTrace) {
              //     print('fgjnhbgvcvbn');
              //     print(error);
              //     return Text('$error');
              //   },
              //   loading: () {
              //     print('LOADING');
              //    return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //
              //   }
              // ),


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
              FilmFlexFutureBuilder(
                key: const Key('popularMovie'),
                height: 320.h,
                height2: 320.h,
                future: filmFlexApi.getPopularMovie(context),
                isPopular: true,
                // filmFlexApi: filmFlexApi
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  topPadding: 10.0.w,
                  bottomPadding: 10.0.w),
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
              FilmFlexFutureBuilder(
                key: const Key('upcomingMovie'),
                height: 320.h,
                height2: 320.h,
                future: filmFlexApi.getUpcomingMovies(context),
                // filmFlexApi: filmFlexApi
              ).paddingOnly(
                  leftPadding: 10.0.w,
                  topPadding: 10.0.w,
                  bottomPadding: 10.0.w),
            ],
          ),
        ),
      ),
    );
  }
}

