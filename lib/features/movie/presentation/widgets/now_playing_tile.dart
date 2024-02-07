import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_string.dart';
import '../pages/screen.dart';

class NowPlayingMovieTile extends StatelessWidget {
  final Movie? popularMovie;

  const NowPlayingMovieTile({
    super.key,
    this.popularMovie,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          context.push(MovieDetail(movie: popularMovie!), context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 212.h,
              width: 143.w,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.w),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl:
                '${AppString.baseImageUrl}w500/${popularMovie?.posterPath}',
                imageBuilder: (context, imageProvider) => Container(
                  width: 143.w,
                  height: 212.h,
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.all(
                        Radius.circular(10.w),
                      ),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
                ),
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 150.w,
              height: 60.h,
              child: Text(
                popularMovie?.originalTitle ?? '',
                textAlign: TextAlign.left,
                maxLines: 10,
                softWrap: true,
                style:  Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
