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

extension StringChecks on String? {
  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;
}

extension PaddingWidgets on Widget {
  Widget paddingSymmetricHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Widget paddingSymmetricVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingOnly(
          {double? leftPadding,
          double? rightPadding,
          double? topPadding,
          double? bottomPadding}) =>
      Padding(
        padding: EdgeInsets.only(
            left: leftPadding ?? 0.0,
            right: rightPadding ?? 0.0,
            top: topPadding ?? 0.0,
            bottom: bottomPadding ?? 0.0),
        child: this,
      );
}