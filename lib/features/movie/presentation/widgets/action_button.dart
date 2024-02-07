import 'package:flutter/material.dart';

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
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).textTheme.displayLarge!.color!,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).textTheme.displayLarge!.color,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}
