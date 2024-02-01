import 'dart:async';

import 'package:filmflex/core/constant/ui_helper.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:filmflex/providers/provider.dart';
import 'package:filmflex/src/common_widget/search_tile.dart';
import 'package:filmflex/src/screen/popular_movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/api/film_flex_api.dart';

final filmFlexApi = FilmFlexApi();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final movie = Movie();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(
            'Back2'.svg,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(builder: (context, ref, child) {
          final query = ref.watch(searchQueryProvider);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiHelper.verticalSmallestSpacing,
              SizedBox(
                height: 50,
                child: TextField(
                  focusNode: _focusNode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) {
                      _debounce?.cancel();
                    }
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      ref.read(searchQueryProvider.notifier).state = value;
                      filmFlexApi.fetchMovies(context, value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: const OutlineInputBorder(
                      gapPadding: 3.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                    )),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                    )),
                  ),
                ),
              ),
              UiHelper.verticalSmallSpacing,
              FutureBuilder(
                future: filmFlexApi.fetchMovies(context, query),
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
                    final searchResults = snapshot.data;
                    return searchResults!.isNotEmpty
                        ? Expanded(
                            child: GridView.builder(
                              itemCount: searchResults.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0),
                              itemBuilder: (context, index) {
                                final searchResult = searchResults[index];
                                return GestureDetector(
                                    onTap: () {
                                      context.push(PopularMovieDetail(
                                          popularMovie: searchResult), context);
                                    },
                                    child: SearchTile(movie: searchResult));
                              },
                            ),
                          )
                        : Expanded(
                      child: Center(
                              child: _searchController.text.isNotNullOrEmpty
                                  ? Text(
                                      'Search Not Found',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    )
                                  : null,
                            ),
                          );
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}


