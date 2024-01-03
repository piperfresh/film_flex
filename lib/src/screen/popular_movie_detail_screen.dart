import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/app_colors.dart';
import 'package:filmflex/core/api/film_flex_api.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:filmflex/src/common_widget/popular_movie_cast_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_style.dart';
import '../../constant/ui_helper.dart';
import '../common_widget/details_column_widget.dart';

class PopularMovieDetail extends StatelessWidget {
  final Movie popularMovie;
  final filmFlexApi = FilmFlexApi();
  final List<Map<int, String>> genresIdDetails = const [
    {12: 'ADVENTURE'},
    {14: 'FANTASY'},
    {16: 'ANIMATION'},
    {18: 'DRAMA'},
    {27: 'HORROR'},
    {28: 'ACTION'},
    {35: 'COMEDY'},
    {36: 'HISTORY'},
    {37: 'WESTERN'},
    {53: 'THRILLER'},
    {80: 'CRIME'},
    {99: 'DOCUMENTARY'},
    {878: 'SCIENCE FICTION'},
    {9648: 'MYSTERY'},
    {10402: 'MUSIC'},
    {10749: 'ROMANCE'},
    {10751: 'FAMILY'},
    {10752: 'WAR'},
    {10770: 'TV MOVIE'}
  ];

   PopularMovieDetail({super.key, required this.popularMovie});

  @override
  Widget build(BuildContext context) {


    List<String> genresNames = popularMovie.genreIds!.map((id) {
      Map<int, String> genre = genresIdDetails.firstWhere(
        (element) => element.keys.first == id,
        orElse: () => {0: 'UNKNOWN'},
      );
      return genre[id] ?? 'UNKNOWN';
    }).toList();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20.0.h,
            child: SizedBox(
              // color: Colors.red,
              height: 210.h,
              // height: 280.h,
              width: 440.w,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500/${popularMovie.backdropPath}',
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity.w,
                  height: 280.h,
                  decoration: BoxDecoration(
                      // borderRadius:  BorderRadius.all(
                      //   Radius.circular(10.w),
                      // ),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill)),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: 60.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              height: 30.h,
              width: 400.w,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('Back'.svg)),
                  SvgPicture.asset('Menu2'.svg)
                ],
              ),
            ),
          ),
          Positioned(
            top: 320.0,
            child: Container(
              height: 500.h,
              width: 360.w,
              // color: Colors.white,
              // color: Theme.of(context).textTheme.displayLarge?.backgroundColor,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textTheme.displayLarge?.backgroundColor,
                // color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Container(
                height: 500.h,
                width: 360.w,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).textTheme.displayLarge?.backgroundColor,
                  // color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.w,
                            height: 92.h,
                            child: Text(
                              popularMovie.originalTitle ?? '',
                              textAlign: TextAlign.left,
                              maxLines: 10,
                              softWrap: true,
                              // style: AppStyle.bigMullish,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          SvgPicture.asset('favorite'.svg),
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Row(
                        children: [
                          Text('Popularity:   ',
                              style: Theme.of(context).textTheme.bodyMedium
                              // ?.copyWith(color: AppColors.greyColor),
                              ),
                          Text(
                            popularMovie.popularity!
                                .toStringAsFixed(2)
                                .toString(),
                            // style: AppStyle.smallMullish,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/Star.svg'),
                          UiHelper.horizontalSmallestSpacing,
                          Text(
                            '${popularMovie.voteAverage!.toStringAsFixed(1)}/10 TMDB',
                            // style: AppStyle.smallMullish
                            //     .copyWith(color: AppColors.greyColor),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.greyColor),
                          ),
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Wrap(
                        spacing: 5,
                        direction: Axis.horizontal,
                        children: genresNames
                            .map(
                              (genre) => Chip(
                                side: BorderSide.none,
                                backgroundColor: AppColors.chipColor,
                                padding: EdgeInsets.zero,
                                shape: const StadiumBorder(),
                                label: Text(
                                  genre.toString(),
                                  // style: AppStyle.smallestMullish.copyWith(
                                  //     fontSize: 8.sp,
                                  //     color: AppColors.chipTextColor),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 8.sp,
                                          color: AppColors.chipTextColor),
                                ),
                              ),
                        )
                            .toList(),
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailColumnWidget(
                            firstChild: 'Language',
                            secondChild: popularMovie.originalLanguage!,
                            popularMovie: popularMovie,
                          ),
                          DetailColumnWidget(
                            firstChild: 'Rating',
                            secondChild:
                                popularMovie.adult == false ? 'G' : 'PG - 13',
                            popularMovie: popularMovie,
                          ),
                          DetailColumnWidget(
                            firstChild: 'Release Date',
                            secondChild: popularMovie.releaseDate!,
                            popularMovie: popularMovie,
                          ),
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        'Description',
                        // style: AppStyle.biggestMerriWeather,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        popularMovie.overview!,
                        style: AppStyle.smallMullish.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        'Cast',
                        // style: AppStyle.biggestMerriWeather,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      FutureBuilder(
                        future: filmFlexApi.getPopularMoviesCast(
                            context, popularMovie.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            final casts = snapshot.data;
                            return SizedBox(

                              height: 200.h,
                              width: 360.w,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: casts!.length,
                                itemBuilder: (context, index) {
                                  final popularMovieCast = casts[index];
                                  return PopularMovieCastTile(
                                      popularMovieCast: popularMovieCast);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 12.w,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ).paddingOnly(
                      leftPadding: 10.w,
                      topPadding: 22.h,
                      bottomPadding: 22.h,
                      rightPadding: 10.w),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
