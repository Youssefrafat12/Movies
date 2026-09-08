import 'package:translator/translator.dart';

class MovieTranslationService {
  MovieTranslationService._();

  static final instance = MovieTranslationService._();

  final GoogleTranslator _translator = GoogleTranslator();
  final Map<String, String> _arabicCache = {};

  Future<String?> translateToArabic(String text) async {
    final cachedTranslation = _arabicCache[text];
    if (cachedTranslation != null) return cachedTranslation;

    try {
      final translation = await _translator.translate(
        text,
        from: 'auto',
        to: 'ar',
      );
      _arabicCache[text] = translation.text;
      return translation.text;
    } catch (_) {
      return null;
    }
  }
}