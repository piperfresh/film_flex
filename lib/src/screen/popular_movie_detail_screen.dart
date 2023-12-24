import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/app_colors.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_style.dart';
import '../../constant/ui_helper.dart';

class PopularMovieDetail extends StatelessWidget {
  final PopularMovie popularMovie;

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

  const PopularMovieDetail({super.key, required this.popularMovie});

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
            top: 20.0,
            child: SizedBox(
              height: 310,
              width: 440,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500/${popularMovie.backdropPath}',
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 310,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: DecorationImage(image: imageProvider)),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Container(
              height: 30,
              width: 400,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/icons/Back.svg')),
                  SvgPicture.asset('assets/icons/Menu2.svg')
                ],
              ),
            ),
          ),
          Positioned(
            top: 280.0,
            child: Container(
              height: 600,
              width: 412,
              color: Colors.transparent,
              child: Container(
                height: 600,
                width: 412,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 92,
                            child: Text(
                              popularMovie.originalTitle ?? '',
                              textAlign: TextAlign.left,
                              maxLines: 10,
                              softWrap: true,
                              style: AppStyle.bigMullish,
                            ),
                          ),
                          SvgPicture.asset('assets/icons/favorite.svg'),
                        ],
                      ),
                      UiHelper.verticalSmallestSpacing,
                      Row(
                        children: [
                          Text(
                            'Popularity:   ',
                            style: AppStyle.smallMullish
                                .copyWith(color: AppColors.greyColor),
                          ),
                          Text(
                            popularMovie.popularity!
                                .toStringAsFixed(2)
                                .toString(),
                            style: AppStyle.smallMullish,
                          )
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
                                  style: AppStyle.smallestMullish.copyWith(
                                      fontSize: 8,
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
                     UiHelper.verticalSmallSpacing,
                      Text(
                        'Description',
                        style: AppStyle.biggestMerriWeather,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailColumnWidget extends StatelessWidget {
  const DetailColumnWidget({
    super.key,
    required this.popularMovie,
    required this.firstChild,
    required this.secondChild,
  });

  final PopularMovie popularMovie;
  final String firstChild;
  final String secondChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstChild,
          style: AppStyle.smallMullish.copyWith(color: AppColors.greyColor),
        ),
        Text(secondChild, style: AppStyle.smallMullish)
      ],
    );
  }
}