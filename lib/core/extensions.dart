import 'package:flutter/material.dart';

extension AssetName on String {
  String get svg => 'assets/icons/$this.svg';
}

extension NavigationPush on BuildContext {
  Future<T?> push<T extends Object?>(Widget widget, BuildContext context) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
