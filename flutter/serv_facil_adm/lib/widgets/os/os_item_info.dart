import 'package:flutter/material.dart';
import 'package:serv_facil/models/os.dart';

class OsItemInfo extends StatelessWidget {
  const OsItemInfo({
    super.key,
    required this.title,
    required this.content,
    required this.os
  });

  final String title;
  final String content;
  final Os os;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: !os.finished ? Theme.of(context).colorScheme.onTertiary : Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 20,
              color: !os.finished ? Theme.of(context).colorScheme.onTertiary : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
