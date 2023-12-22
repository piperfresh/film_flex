import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_style.dart';
import '../../core/api/film_flex_api.dart';
import '../common_widget/common_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final filmFlexApi = FilmFlexApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/Menu.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Film Flix',
          style: AppStyle.medium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/Notif.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Popular',
                    style: AppStyle.medium,
                  ),
                  ActionButton(
                    text: 'See more',
                    onPressed: () {},
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: filmFlexApi.getPopularMovie(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  final movieList = snapshot.data;
                  return SizedBox(
                    height: 280,
                    child: ListView.separated(
                      itemCount: movieList!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final popularMovie = movieList[index];
                        return PopularMovieTile(
                          popularMovie: popularMovie,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 16,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
