import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_string.dart';



class SearchTile extends StatelessWidget {
  final Movie movie;

  const SearchTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212.h,
      width: 143.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: '${AppString.baseImageUrl}w500/${movie.posterPath}',
        imageBuilder: (context, imageProvider) => Container(
          width: 143,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
