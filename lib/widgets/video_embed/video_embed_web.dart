import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import 'video_url.dart';

/// Plays [url] inline on the page: a native `<video>` player for direct
/// files, or an iframe for YouTube / Vimeo / Google Drive links.
class VideoEmbed extends StatelessWidget {
  const VideoEmbed({super.key, required this.url, this.title});

  final String url;
  final String? title;

  static final Set<String> _registered = {};

  @override
  Widget build(BuildContext context) {
    final viewType = 'video-embed-$url';
    if (_registered.add(viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(viewType, (int _) {
        if (isDirectVideoFile(url)) {
          return web.HTMLVideoElement()
            ..src = url
            ..controls = true
            ..preload = 'metadata'
            ..setAttribute('playsinline', '')
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.backgroundColor = 'black';
        }
        return web.HTMLIFrameElement()
          ..src = toEmbedUrl(url)
          ..title = title ?? 'Video'
          ..allow =
              'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen'
          ..allowFullscreen = true
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 880),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: HtmlElementView(viewType: viewType),
      ),
    );
  }
}
