import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/features/movie/data/models/popular_movie_cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_string.dart';
import '../../../../core/constant/ui_helper.dart';

class MovieCastTile extends StatelessWidget {
  final MovieCast movieCast;

  const MovieCastTile({super.key, required this.movieCast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 76.h,
          width: 72.w,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.w),
            ),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.scaleDown,
            imageUrl:
                '${AppString.baseImageUrl}w200/${movieCast.profilePath}',
            imageBuilder: (context, imageProvider) => Container(
              height: 76.h,
              width: 72.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
                borderRadius:  BorderRadius.all(
                  Radius.circular(10.w),
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
          width: 80.w,
          height: 40.h,
          child: Text(
            movieCast.originalName!,
            maxLines: 2,
            textAlign: TextAlign.left,
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),
        ),
      ],
    );
  }
}
