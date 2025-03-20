import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/language_service.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Use the LanguageService to get supported locales
  static List<Locale> get supportedLocales => LanguageService().locales;

  Future<bool> load() async {
    print('Attempting to load locale: ${locale.languageCode}');
    
    try {
      // Try to handle special cases based on filename patterns first
      String assetPath;
      
      // Special handling for 'swa' locale
      if (locale.languageCode == 'swa') {
        print('Using special handling for Swahili (swa)');
        assetPath = 'assets/l10n/app_swa.json';
      }
      // Special handling for Kurdish locale
      else if (locale.languageCode == 'ku') {
        print('Using special handling for Kurdish (ku)');
        assetPath = 'assets/l10n/app_ku.json';
      }
      // For Chinese variants, we'll match the filename with the locale pattern
      else if (locale.languageCode == 'zh' && locale.countryCode != null) {
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
      
      print('Attempting to load file: $assetPath');
      
      // Try looking for files with the exact language code from the Locale
      try {
        String jsonString = await rootBundle.loadString(assetPath);
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        
        // Check for missing required keys
        List<String> requiredKeys = [
          'app_title', 'home_title', 'delete_all_title', 'unbeliever', 
          'believer', 'unknown', 'add_person_hint', 'save', 'cancel',
          'delete_all', 'delete_all_confirmation', 'yes', 'no', 'menu',
          'home', 'language', 'language_selection', 'about', 'about_title',
          'about_app_title', 'about_app_description1', 'about_app_description2'
        ];
        
        List<String> missingKeys = [];
        for (String key in requiredKeys) {
          if (!jsonMap.containsKey(key)) {
            missingKeys.add(key);
          }
        }
        
        if (missingKeys.isNotEmpty) {
          print('WARNING: Missing keys in ${locale.languageCode} locale: ${missingKeys.join(', ')}');
        }
        
        _localizedStrings = jsonMap.map((key, value) {
          return MapEntry(key, value.toString());
        });
        
        print('Successfully loaded file: $assetPath');
        return true;
      } catch (e) {
        print('Error loading $assetPath: $e');
        // If we couldn't find the exact match, try the simple language code as fallback
        if (locale.countryCode != null) {
          assetPath = 'assets/l10n/app_${locale.languageCode}.json';
          print('Trying fallback: $assetPath');
          String jsonString = await rootBundle.loadString(assetPath);
          Map<String, dynamic> jsonMap = json.decode(jsonString);
          
          // Check for missing required keys in fallback file
          List<String> requiredKeys = [
            'app_title', 'home_title', 'delete_all_title', 'unbeliever', 
            'believer', 'unknown', 'add_person_hint', 'save', 'cancel',
            'delete_all', 'delete_all_confirmation', 'yes', 'no', 'menu',
            'home', 'language', 'language_selection', 'about', 'about_title',
            'about_app_title', 'about_app_description1', 'about_app_description2'
          ];
          
          List<String> missingKeys = [];
          for (String key in requiredKeys) {
            if (!jsonMap.containsKey(key)) {
              missingKeys.add(key);
            }
          }
          
          if (missingKeys.isNotEmpty) {
            print('WARNING: Missing keys in fallback ${locale.languageCode} locale: ${missingKeys.join(', ')}');
          }
          
          _localizedStrings = jsonMap.map((key, value) {
            return MapEntry(key, value.toString());
          });
          
          print('Successfully loaded fallback: $assetPath');
          return true;
        } else {
          // If we still can't find it, throw to trigger the fallback to English
          print('Cannot find language file for ${locale.languageCode}, falling back to English');
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
    if (_localizedStrings == null || _localizedStrings.isEmpty) {
      print('WARNING: Localized strings is empty for ${locale.languageCode}');
      return key; // Return the key as fallback
    }
    
    // Null safety check - return the key itself if translation not found
    final value = _localizedStrings[key];
    if (value == null) {
      print('WARNING: Missing translation for key "$key" in ${locale.languageCode}');
      return key;
    }
    
    return value;
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
    print('Checking if locale is supported: ${locale.languageCode}');
    
    // Check if the language code is supported
    final languageSupported = AppLocalizations.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
    
    // Special debug for Swahili
    if (locale.languageCode == 'swa') {
      print('Special debug - Checking support for ${locale.languageCode}');
      print('Is supported: $languageSupported');
      print('Supported locales: ${AppLocalizations.supportedLocales.map((e) => e.languageCode).toList()}');
    }
    
    // Special debug for Kurdish
    if (locale.languageCode == 'ku') {
      print('Special debug - Checking support for Kurdish');
      print('Is Kurdish supported: $languageSupported');
      print('Supported locales: ${AppLocalizations.supportedLocales.map((e) => e.languageCode).toList()}');
    }
    
    // If the language has a country code, check if the specific locale is supported
    if (locale.countryCode != null) {
      final specificSupport = AppLocalizations.supportedLocales.any(
        (supportedLocale) => 
          supportedLocale.languageCode == locale.languageCode && 
          supportedLocale.countryCode == locale.countryCode
      );
      
      if (locale.languageCode == 'swa') {
        print('Has country code: ${locale.countryCode}');
        print('Specific support: $specificSupport');
      }
      
      return specificSupport;
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