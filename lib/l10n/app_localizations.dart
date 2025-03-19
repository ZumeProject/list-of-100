import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('am'),
    const Locale('ar'),
    const Locale('ar', 'JO'),
    const Locale('ar', 'TN'),
    const Locale('hy'),
    const Locale('bn'),
    const Locale('bho'),
    const Locale('bs'),
    const Locale('my'),
    const Locale('zh', 'HK'),
    const Locale('zh', 'CN'),
    const Locale('zh', 'TW'),
    const Locale('hr'),
    const Locale('fr'),
    const Locale('de'),
    const Locale('gu'),
    const Locale('ha'),
    const Locale('hi'),
    const Locale('id'),
    const Locale('it'),
    const Locale('ja'),
    const Locale('kn'),
    const Locale('ko'),
    const Locale('ku'),
    const Locale('lo'),
    const Locale('mai'),
    const Locale('ml'),
    const Locale('mr'),
    const Locale('ne'),
    const Locale('or'),
    const Locale('fa'),
    const Locale('pl'),
    const Locale('pt'),
    const Locale('pa'),
    const Locale('pa', 'PK'),
    const Locale('ru'),
    const Locale('ro'),
    const Locale('sl'),
    const Locale('so'),
    const Locale('es'),
    const Locale('swa'),
    const Locale('ta'),
    const Locale('te'),
    const Locale('th'),
    const Locale('tr'),
    const Locale('ur'),
    const Locale('vi'),
    const Locale('yo'),
  ];

  Future<bool> load() async {
    try {
      // Try to handle special cases based on filename patterns first
      String assetPath;
      
      // For Chinese variants, we'll match the filename with the locale pattern
      if (locale.languageCode == 'zh' && locale.countryCode != null) {
        // Try using the country code
        String suffix = locale.countryCode!.toLowerCase();
        assetPath = 'assets/l10n/app_zh$suffix.json';
      } 
      // For Punjabi with Pakistan country code
      else if (locale.languageCode == 'pa' && locale.countryCode == 'PK') {
        assetPath = 'assets/l10n/app_pa_pk.json';
      }
      // For direct matches with country code
      else if (locale.countryCode != null) {
        assetPath = 'assets/l10n/app_${locale.languageCode}_${locale.countryCode!.toLowerCase()}.json';
      }
      // For direct matches with only language code
      else {
        assetPath = 'assets/l10n/app_${locale.languageCode}.json';
      }
      
      // Also try looking for files with the exact language code from the Locale
      try {
        String jsonString = await rootBundle.loadString(assetPath);
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        
        _localizedStrings = jsonMap.map((key, value) {
          return MapEntry(key, value.toString());
        });
        
        return true;
      } catch (e) {
        // If we couldn't find the exact match, try the simple language code as fallback
        if (locale.countryCode != null) {
          assetPath = 'assets/l10n/app_${locale.languageCode}.json';
          String jsonString = await rootBundle.loadString(assetPath);
          Map<String, dynamic> jsonMap = json.decode(jsonString);
          
          _localizedStrings = jsonMap.map((key, value) {
            return MapEntry(key, value.toString());
          });
          
          return true;
        } else {
          // If we still can't find it, throw to trigger the fallback to English
          throw Exception('Language file not found');
        }
      }
    } catch (e) {
      print('Error loading locale ${locale.languageCode}: $e');
      try {
        // Fall back to English
        String jsonString = await rootBundle.loadString('assets/l10n/app_en.json');
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        
        _localizedStrings = jsonMap.map((key, value) {
          return MapEntry(key, value.toString());
        });
        
        print('Falling back to English locale due to error with ${locale.languageCode}');
        return true;
      } catch (e) {
        print('Critical error loading language files: $e');
        // Initialize with empty map to prevent null errors
        _localizedStrings = {};
        return false;
      }
    }
  }

  String translate(String key) {
    // Null safety check - return the key itself if translation not found
    return _localizedStrings[key] ?? key;
  }

  // Convenience method to keep the code in the widgets concise
  String get appTitle => translate('app_title');
  String get homeTitle => translate('home_title');
  String get deleteAllTitle => translate('delete_all_title');
  String get unbeliever => translate('unbeliever');
  String get believer => translate('believer');
  String get unknown => translate('unknown');
  String get addPersonHint => translate('add_person_hint');
  String get save => translate('save');
  String get cancel => translate('cancel');
  String get deleteAll => translate('delete_all');
  String get deleteAllConfirmation => translate('delete_all_confirmation');
  String get yes => translate('yes');
  String get no => translate('no');
  String get menu => translate('menu');
  String get home => translate('home');
  String get language => translate('language');
  String get languageSelection => translate('language_selection');
  String get about => translate('about');
  String get aboutTitle => translate('about_title');
  String get aboutAppTitle => translate('about_app_title');
  String get aboutAppDescription1 => translate('about_app_description1');
  String get aboutAppDescription2 => translate('about_app_description2');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Check if the language code is supported
    final languageSupported = AppLocalizations.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
    
    // If the language has a country code, check if the specific locale is supported
    if (locale.countryCode != null) {
      return AppLocalizations.supportedLocales.any(
        (supportedLocale) => 
          supportedLocale.languageCode == locale.languageCode && 
          supportedLocale.countryCode == locale.countryCode
      );
    }
    
    return languageSupported;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 