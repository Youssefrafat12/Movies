String movieImageUrl(String? source) {
  if (source == null || source.isEmpty) return '';
  if (!source.contains('://yts.gg/')) return source;

  return 'https://images.weserv.nl/?url=${Uri.encodeComponent(source)}';
}