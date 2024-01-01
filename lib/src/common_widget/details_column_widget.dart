import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_style.dart';
import '../../model/movie_list.dart';

class DetailColumnWidget extends StatelessWidget {
  const DetailColumnWidget({
    super.key,
    required this.popularMovie,
    required this.firstChild,
    required this.secondChild,
  });

  final Movie popularMovie;
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
