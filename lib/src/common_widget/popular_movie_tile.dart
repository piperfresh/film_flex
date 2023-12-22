import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/constant/constants.dart';
import 'package:filmflex/model/movie_list.dart';
import 'package:flutter/material.dart';

class PopularMovieTile extends StatelessWidget {
  final PopularMovie? popularMovie;

  const PopularMovieTile({
    super.key,
    this.popularMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            popularMovie?.originalTitle ?? '',
            style: AppStyle.mediumMullish,
          ),
        )
      ],
    );
  }
}
