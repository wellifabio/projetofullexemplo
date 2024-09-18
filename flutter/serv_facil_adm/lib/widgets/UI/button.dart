import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.filled = true,
    this.margin = const EdgeInsets.symmetric(vertical: 7),
  });

  final Function()? onTap;
  final String text;
  final bool filled;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17),
          width: double.infinity,
          decoration: BoxDecoration(
            color: filled
                ? Theme.of(context).colorScheme.tertiary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: !filled
                ? Border.all(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.75),
                    width: 4,
                  )
                : Border.all(style: BorderStyle.none),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: filled
                  ? Theme.of(context).colorScheme.onTertiary
                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
