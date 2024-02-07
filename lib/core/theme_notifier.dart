import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'film_flex_theme.dart';

enum ThemeType { dark, light }

class ThemeNotifier extends StateNotifier<ThemeType> {
  ThemeNotifier() : super(ThemeType.light) {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    state = isDarkMode ? ThemeType.dark : ThemeType.light;
  }

  Future<void> toggleTheme() async {
    state = state == ThemeType.light ? ThemeType.dark : ThemeType.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', state == ThemeType.dark);
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeType>((ref) => ThemeNotifier());

final themeProvider = Provider<ThemeData>((ref) {
  final themeType = ref.watch(themeNotifierProvider);
  return themeType == ThemeType.light
      ? FilmFlexTheme.lightTheme()
      : FilmFlexTheme.darkTheme();
});
