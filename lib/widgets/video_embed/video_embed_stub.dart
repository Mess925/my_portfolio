import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../hover_link.dart';

/// Non-web fallback: inline HTML video isn't available, so link out instead.
class VideoEmbed extends StatelessWidget {
  const VideoEmbed({super.key, required this.url, this.title});

  final String url;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return HoverLink(
      text: title ?? 'Watch video →',
      style: Theme.of(context).textTheme.labelLarge,
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
    );
  }
}
