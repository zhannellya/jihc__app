import 'package:flutter/material.dart';

class BuildCustomText extends StatelessWidget {
  final String text;
  const BuildCustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}