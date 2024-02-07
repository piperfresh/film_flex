import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/presentation/providers/movie_provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/more_movie_tile.dart';
import 'screen.dart';

class MorePopularMovieScreen extends ConsumerWidget {
  const MorePopularMovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(popularMoviesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(
            'Back2'.svg,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.displayLarge!.color!,
                BlendMode.srcIn),
          ).paddingOnly(leftPadding: 0.0),
        ),
        title: Text(
          'Popular Movies',
          // style: AppStyle.bigMullish,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          Icon(
            Icons.menu,
            color: Theme.of(context).textTheme.displayLarge!.color!,
          ).paddingOnly(rightPadding: 10.0),
        ],
      ),
      body: popularMovies.when(
        data: (popularMovies) {
          return Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                final movie = popularMovies[index];
                return GestureDetector(
                    onTap: () {
                      context.push(MovieDetail(movie: movie), context);
                    },
                    child: MoreMovieTile(movie: movie));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
