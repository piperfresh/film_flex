import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/app_colors.dart';
import 'package:filmflex/constant/app_style.dart';
import 'package:filmflex/constant/ui_helper.dart';
import 'package:filmflex/model/popular_movie_cast.dart';
import 'package:flutter/material.dart';

import '../../constant/app_string.dart';

class PopularMovieCastTile extends StatelessWidget {
  final PopularMovieCast popularMovieCast;

  const PopularMovieCastTile({super.key, required this.popularMovieCast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 76,
          width: 72,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.scaleDown,
            imageUrl:
                '${AppString.baseImageUrl}w200/${popularMovieCast.profilePath}',
            imageBuilder: (context, imageProvider) => Container(
              height: 76,
              width: 72,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        UiHelper.verticalSmallestSpacing,
        SizedBox(
          width: 80,
          height: 40,
          child: Text(
            popularMovieCast.originalName!,
            maxLines: 2,
            textAlign: TextAlign.left,
            softWrap: true,
            style: AppStyle.smallMullish.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
