/// Whether [url] points straight at a video file the browser can play in a
/// `<video>` tag, as opposed to a page that must be embedded in an iframe.
bool isDirectVideoFile(String url) {
  final path = Uri.parse(url).path.toLowerCase();
  return path.endsWith('.mp4') ||
      path.endsWith('.webm') ||
      path.endsWith('.mov') ||
      path.endsWith('.m4v');
}

/// Converts common share links (YouTube, Vimeo, Google Drive) to their
/// embeddable form. Anything else is returned unchanged.
String toEmbedUrl(String url) {
  final uri = Uri.parse(url);
  final host = uri.host.replaceFirst('www.', '');

  if (host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
    return 'https://www.youtube.com/embed/${uri.pathSegments.first}';
  }
  if (host == 'youtube.com' || host == 'm.youtube.com') {
    final id = uri.queryParameters['v'];
    if (id != null) return 'https://www.youtube.com/embed/$id';
  }
  if (host == 'vimeo.com' && uri.pathSegments.isNotEmpty) {
    return 'https://player.vimeo.com/video/${uri.pathSegments.first}';
  }
  if (host == 'drive.google.com') {
    final segs = uri.pathSegments;
    final i = segs.indexOf('d');
    if (i != -1 && i + 1 < segs.length) {
      return 'https://drive.google.com/file/d/${segs[i + 1]}/preview';
    }
  }
  return url;
}
