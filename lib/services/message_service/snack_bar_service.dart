
import 'package:flutter/material.dart';

import '../../core/constant/app_style.dart';

class SnackBarService {
  static errorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppStyle.mediumMullish.copyWith(color: Colors.white),),
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.red,
      ),
    );
  }
}
