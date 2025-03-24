import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../services/language_service.dart';

// Custom delegate to provide fallback for Material localization
class FallbackMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // Always use English as the fallback for Material widgets
    return DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

// Custom delegate to provide fallback for Cupertino localization
class FallbackCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    // Always use English as the fallback for Cupertino widgets
    return DefaultCupertinoLocalizations();
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  // Add the fallback delegates for widget libraries
  static const LocalizationsDelegate<MaterialLocalizations> fallbackMaterialDelegate = 
      FallbackMaterialLocalizationsDelegate();
      
  static const LocalizationsDelegate<CupertinoLocalizations> fallbackCupertinoDelegate = 
      FallbackCupertinoLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? 
        AppLocalizations(const Locale('en')); // Fallback to English if not found
  }

  // Use the LanguageService to get supported locales
  static List<Locale> get supportedLocales => LanguageService().locales;

  Future<bool> load() async {
    try {
      // Try to handle special cases based on filename patterns first
      String assetPath;
      
      // For Chinese or other languages with country code variants
      if (locale.countryCode != null) {
        // Format: language_COUNTRY (e.g., zh_CN, zh_TW, zh_HK)
        assetPath = 'assets/l10n/app_${locale.languageCode}_${locale.countryCode!.toLowerCase()}.json';
      } 
      // For direct matches with only language code
      else {
        assetPath = 'assets/l10n/app_${locale.languageCode}.json';
      }
      
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
          'about_app_title', 'about_app_description1', 'about_app_description2',
          'visit_zume_training'
        ];
        
        List<String> missingKeys = [];
        for (String key in requiredKeys) {
          if (!jsonMap.containsKey(key)) {
            missingKeys.add(key);
          }
        }
        
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
          
          // Check for missing required keys in fallback file
          List<String> requiredKeys = [
            'app_title', 'home_title', 'delete_all_title', 'unbeliever', 
            'believer', 'unknown', 'add_person_hint', 'save', 'cancel',
            'delete_all', 'delete_all_confirmation', 'yes', 'no', 'menu',
            'home', 'language', 'language_selection', 'about', 'about_title',
            'about_app_title', 'about_app_description1', 'about_app_description2',
            'visit_zume_training'
          ];
          
          List<String> missingKeys = [];
          for (String key in requiredKeys) {
            if (!jsonMap.containsKey(key)) {
              missingKeys.add(key);
            }
          }
          
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
      try {
        // Fall back to English
        String jsonString = await rootBundle.loadString('assets/l10n/app_en.json');
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        
        _localizedStrings = jsonMap.map((key, value) {
          return MapEntry(key, value.toString());
        });
        
        return true;
      } catch (e) {
        // Initialize with empty map to prevent null errors
        _localizedStrings = {};
        return false;
      }
    }
  }

  String translate(String key) {
    if (_localizedStrings.isEmpty) {
      return key; // Return the key as fallback
    }
    
    // Null safety check - return the key itself if translation not found
    final value = _localizedStrings[key];
    if (value == null) {
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
  String get delete => translate('delete');
  String get deleteAll => translate('delete_all');
  String get deleteAllConfirmation => translate('delete_all_confirmation');
  String get deleteConfirmation => translate('delete_confirmation');
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
  String get visitZumeTraining => translate('visit_zume_training');
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
      final specificSupport = AppLocalizations.supportedLocales.any(
        (supportedLocale) => 
          supportedLocale.languageCode == locale.languageCode && 
          supportedLocale.countryCode == locale.countryCode
      );
      
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