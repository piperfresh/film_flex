import 'package:flutter/material.dart';

import '../../constant/constants.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 25,
      minWidth: 25,
      onPressed: onPressed,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: Text(
        text,
        style: AppStyle.smallestMullish,
      ),
    );
  }
}
