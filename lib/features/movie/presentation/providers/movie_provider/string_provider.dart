import 'package:filmflex/features/movie/presentation/providers/movie_provider/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieCastIdProvider = StateProvider((ref) => '');
final  searchQueryProvider = StateProvider<String>((ref) => '');
