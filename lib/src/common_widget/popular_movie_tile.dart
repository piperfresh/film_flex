import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/constants.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:filmflex/src/screen/popular_movie_detail_screen.dart';
import 'package:flutter/material.dart';

class PopularMovieTile extends StatelessWidget {
  final PopularMovie? popularMovie;

  const PopularMovieTile({
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
              height: 212,
              width: 143,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500/${popularMovie?.posterPath}',
                imageBuilder: (context, imageProvider) => Container(
                  width: 143,
                  height: 212,
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              height: 60,
              child: Text(
                popularMovie?.originalTitle ?? '',
                textAlign: TextAlign.left,
                maxLines: 10,
                softWrap: true,
                style: AppStyle.mediumMullish,
              ),
            ),
            SizedBox(
              width: 148,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popularity:',
                    style: AppStyle.smallestMullish.copyWith(fontSize: 14),
                  ),
                  Text(
                    popularMovie!.popularity!.toStringAsFixed(1).toString(),
                    style: AppStyle.mediumMullish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
