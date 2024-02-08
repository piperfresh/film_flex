import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:filmflex/features/movie/presentation/widgets/movie_cast_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_style.dart';
import '../../../../core/constant/ui_helper.dart';
import '../providers/movie_provider/string_provider.dart';
import '../providers/movie_provider/ui_provider.dart';
import '../widgets/details_column_widget.dart';

class MovieDetail extends ConsumerStatefulWidget {
  final Movie movie;

  const MovieDetail({super.key, required this.movie});

  @override
  ConsumerState<MovieDetail> createState() => _PopularMovieDetailState();
}

class _PopularMovieDetailState extends ConsumerState<MovieDetail> {


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

  /// I used this for the movieCastIdProvider to access the MovieId to get the Cast and i watched the provider
  /// in getMovieCastProvider
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(movieCastIdProvider.notifier).state =
          widget.movie.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieCast = ref.watch(movieCastProvider);
    List<String> genresNames = widget.movie.genreIds!.map((id) {
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
              height: 210.h,
              width: 440.w,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}',
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity.w,
                  height: 280.h,
                  decoration: BoxDecoration(
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
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textTheme.displayLarge?.backgroundColor,
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
                              widget.movie.originalTitle ?? '',
                              textAlign: TextAlign.left,
                              maxLines: 10,
                              softWrap: true,
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
                            widget.movie.popularity!
                                .toStringAsFixed(2)
                                .toString(),
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
                            '${widget.movie.voteAverage!.toStringAsFixed(1)}/10 TMDB',
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
                            secondChild: widget.movie.originalLanguage!,
                            popularMovie: widget.movie,
                          ),
                          DetailColumnWidget(
                            firstChild: 'Rating',
                            secondChild: widget.movie.adult == false
                                ? 'G'
                                : 'PG - 13',
                            popularMovie: widget.movie,
                          ),
                          DetailColumnWidget(
                            firstChild: 'Release Date',
                            secondChild: widget.movie.releaseDate!,
                            popularMovie: widget.movie,
                          ),
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        widget.movie.overview!,
                        style: AppStyle.smallMullish.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Text(
                        'Cast',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      movieCast.when(
                        data: (casts) {
                          return SizedBox(
                            height: 230.h,
                            width: 360.w,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: casts.length,
                              itemBuilder: (context, index) {
                                final movieCast = casts[index];
                                return MovieCastTile(movieCast: movieCast);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 12.w,
                                );
                              },
                            ),
                          );
                        },
                        error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                        loading: () => SizedBox(
                          height: 230.h,
                          width: 360.w,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
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
