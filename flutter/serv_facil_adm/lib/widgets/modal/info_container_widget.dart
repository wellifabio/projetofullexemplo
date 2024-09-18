import 'package:flutter/material.dart';

class InfoContainerWidget extends StatelessWidget {
  const InfoContainerWidget({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: margin,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondary
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
