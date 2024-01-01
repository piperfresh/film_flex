import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/constants.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:filmflex/src/screen/popular_movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PopularMovieDetail(popularMovie: popularMovie!);
          }));
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
                style: AppStyle.mediumMullish,
              ),
            ),
            // SizedBox(
            //   width: 148,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Popularity:',
            //         style: AppStyle.smallestMullish.copyWith(fontSize: 14),
            //       ),
            //       Text(
            //         popularMovie!.popularity!.toStringAsFixed(1).toString(),
            //         style: AppStyle.mediumMullish,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
