import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/app_style.dart';
import '../../core/constant/ui_helper.dart';

class MoreMovieTile extends StatelessWidget {
  final Movie movie;

  MoreMovieTile({super.key, required this.movie});

  final List colorTiles = [
    Colors.grey,
    Colors.blue,
    Colors.green,
    Colors.cyan,
    Colors.blueAccent,
    Colors.pinkAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 120.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppColors.chipColor,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 100.h,
            width: 80.h,
            child: CachedNetworkImage(
              imageUrl: '${AppString.baseImageUrl}w500/${movie.posterPath}',
              imageBuilder: (context, imageProvider) => Container(
                width: 100.w,
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    ),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fill)),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          UiHelper.horizontalSmallestSpacing,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150.w,
                height: 60.h,
                child: Text(
                  movie.originalTitle ?? '',
                  textAlign: TextAlign.left,
                  maxLines: 10,
                  softWrap: true,
                  style: AppStyle.mediumMullish,
                ),
              ),
              Text(
                movie.originalLanguage!,
                style: AppStyle.smallMullish,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/Star.svg'),
                  UiHelper.horizontalSmallestSpacing,
                  Text(
                    movie.voteAverage!.toStringAsFixed(1),
                    style: AppStyle.smallMullish
                        .copyWith(color: AppColors.greyColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).paddingAll(20.0.w),
    ).paddingSymmetricHorizontal(15.0.w);
  }
}
