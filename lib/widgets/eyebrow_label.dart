import 'package:flutter/material.dart';

/// Small uppercase monospace section label ("About", "Experience", ...)
/// used above every section, matching the reference design's eyebrow style.
class EyebrowLabel extends StatelessWidget {
  const EyebrowLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
