import 'package:flutter/material.dart';

/// Model class for a supported language
class SupportedLanguage {
  final String code;
  final String name;
  final String? countryCode;

  const SupportedLanguage({
    required this.code, 
    required this.name, 
    this.countryCode,
  });

  /// Creates a Locale object from this language
  Locale toLocale() {
    return countryCode != null 
        ? Locale(code, countryCode) 
        : Locale(code);
  }
}

/// Service to manage languages in the app
class LanguageService {
  // Singleton instance
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  /// List of all supported languages
  final List<SupportedLanguage> supportedLanguages = [
    const SupportedLanguage(code: 'en', name: 'English'),
    const SupportedLanguage(code: 'am', name: 'አማርኛ (Amharic)'),
    const SupportedLanguage(code: 'ar', name: 'العربية (Arabic)'),
    const SupportedLanguage(code: 'hy', name: 'Հայերեն (Armenian)'),
    const SupportedLanguage(code: 'bn', name: 'বাংলা (Bengali)'),
    const SupportedLanguage(code: 'bho', name: 'भोजपुरी (Bhojpuri)'),
    const SupportedLanguage(code: 'bs', name: 'Bosanski (Bosnian)'),
    const SupportedLanguage(code: 'my', name: 'မြန်မာ (Burmese)'),
    const SupportedLanguage(code: 'zh', name: '廣東話 (Cantonese)', countryCode: 'HK'),
    const SupportedLanguage(code: 'zh', name: '简体中文 (Chinese Simplified)', countryCode: 'CN'),
    const SupportedLanguage(code: 'zh', name: '繁體中文 (Chinese Traditional)', countryCode: 'TW'),
    const SupportedLanguage(code: 'hr', name: 'Hrvatski (Croatian)'),
    const SupportedLanguage(code: 'fr', name: 'Français (French)'),
    const SupportedLanguage(code: 'de', name: 'Deutsch (German)'),
    const SupportedLanguage(code: 'gu', name: 'ગુજરાતી (Gujarati)'),
    const SupportedLanguage(code: 'hi', name: 'हिन्दी (Hindi)'),
    const SupportedLanguage(code: 'id', name: 'Bahasa Indonesia (Indonesian)'),
    const SupportedLanguage(code: 'it', name: 'Italiano (Italian)'),
    const SupportedLanguage(code: 'ja', name: '日本語 (Japanese)'),
    const SupportedLanguage(code: 'kn', name: 'ಕನ್ನಡ (Kannada)'),
    const SupportedLanguage(code: 'ko', name: '한국어 (Korean)'),
    const SupportedLanguage(code: 'lo', name: 'ລາວ (Lao)'),
    const SupportedLanguage(code: 'mai', name: 'मैथिली (Maithili)'),
    const SupportedLanguage(code: 'ml', name: 'മലയാളം (Malayalam)'),
    const SupportedLanguage(code: 'mr', name: 'मराठी (Marathi)'),
    const SupportedLanguage(code: 'ne', name: 'नेपाली (Nepali)'),
    const SupportedLanguage(code: 'or', name: 'ଓଡ଼ିଆ (Odia)'),
    const SupportedLanguage(code: 'fa', name: 'فارسی (Persian)'),
    const SupportedLanguage(code: 'pl', name: 'Polski (Polish)'),
    const SupportedLanguage(code: 'pt', name: 'Português (Portuguese)'),
    const SupportedLanguage(code: 'pa', name: 'ਪੰਜਾਬੀ (Punjabi)'),
    const SupportedLanguage(code: 'pa', name: 'پنجابی (Western Punjabi)', countryCode: 'PK'),
    const SupportedLanguage(code: 'ru', name: 'Русский (Russian)'),
    const SupportedLanguage(code: 'ro', name: 'Română (Romanian)'),
    const SupportedLanguage(code: 'sl', name: 'Slovenščina (Slovenian)'),
    const SupportedLanguage(code: 'so', name: 'Soomaali (Somali)'),
    const SupportedLanguage(code: 'es', name: 'Español (Spanish)'),
    const SupportedLanguage(code: 'sw', name: 'Kiswahili (Swahili)'),
    const SupportedLanguage(code: 'ta', name: 'தமிழ் (Tamil)'),
    const SupportedLanguage(code: 'te', name: 'తెలుగు (Telugu)'),
    const SupportedLanguage(code: 'th', name: 'ไทย (Thai)'),
    const SupportedLanguage(code: 'tr', name: 'Türkçe (Turkish)'),
    const SupportedLanguage(code: 'ur', name: 'اردو (Urdu)'),
    const SupportedLanguage(code: 'vi', name: 'Tiếng Việt (Vietnamese)'),
    const SupportedLanguage(code: 'yo', name: 'Yorùbá (Yoruba)'),
  ];

  /// Get supported locales for MaterialApp configuration
  List<Locale> get locales => supportedLanguages.map((lang) => lang.toLocale()).toList();

  /// Get sorted language list for UI (with English at the top)
  List<SupportedLanguage> getSortedLanguageList() {
    // Create a copy of the list to avoid modifying the original
    final sortedList = List<SupportedLanguage>.from(supportedLanguages);
    
    // Sort alphabetically by name
    sortedList.sort((a, b) => a.name.compareTo(b.name));
    
    // Move English to the top
    final englishIndex = sortedList.indexWhere((lang) => lang.code == 'en');
    if (englishIndex != -1) {
      final english = sortedList.removeAt(englishIndex);
      sortedList.insert(0, english);
    }
    
    return sortedList;
  }
} 