import 'dart:async';

import 'package:filmflex/core/constant/ui_helper.dart';
import 'package:filmflex/core/extensions/extensions.dart';
import 'package:filmflex/features/movie/data/models/movie_list.dart';
import 'package:filmflex/features/movie/presentation/providers/movie_provider/ui_provider.dart';
import 'package:filmflex/features/movie/presentation/widgets/search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/movie_provider/string_provider.dart';
import 'screen.dart';

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
            colorFilter: ColorFilter.mode(Theme.of(context).textTheme.displayLarge!.color!, BlendMode.srcIn),
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
          final fetchMovies = ref.watch(fetchMoviesProvider);
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
                    _debounce = Timer(
                      const Duration(milliseconds: 1000),
                      () {
                        ref.read(searchQueryProvider.notifier).state = value;
                      },
                    );
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
              fetchMovies.when(
                data: (data) {
                  return data.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (context, index) {
                              final searchResult = data[index];
                              return GestureDetector(
                                onTap: () {
                                  context.push(MovieDetail(movie: searchResult),
                                      context);
                                },
                                child: SearchTile(movie: searchResult),
                              );
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
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                loading: () => const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}


