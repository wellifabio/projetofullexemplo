import 'package:flutter/material.dart';

class OutlineddButton extends StatelessWidget {
  const OutlineddButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
  });

  final Function()? onPressed;
  final String text;
  final double width;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: Size(width, double.minPositive),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(
              width: 3,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          overlayColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
