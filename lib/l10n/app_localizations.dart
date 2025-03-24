import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/language_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as gen;

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
  final gen.AppLocalizations _gen;

  AppLocalizations(this.locale, this._gen);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  // Add the fallback delegates for widget libraries
  static const LocalizationsDelegate<MaterialLocalizations> fallbackMaterialDelegate = 
      FallbackMaterialLocalizationsDelegate();
      
  static const LocalizationsDelegate<CupertinoLocalizations> fallbackCupertinoDelegate = 
      FallbackCupertinoLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? 
        AppLocalizations(const Locale('en'), gen.AppLocalizations.of(context)!); // Fallback to English if not found
  }

  // Use the LanguageService to get supported locales
  static List<Locale> get supportedLocales => LanguageService().locales;

  // Convenience methods to keep the code in the widgets concise
  String get appTitle => _gen.app_title;
  String get homeTitle => _gen.home_title;
  String get profileTitle => _gen.profile_title;
  String get deleteAllTitle => _gen.delete_all_title;
  String get unbeliever => _gen.unbeliever;
  String get believer => _gen.believer;
  String get unknown => _gen.unknown;
  String get addPersonHint => _gen.add_person_hint;
  String get save => _gen.save;
  String get cancel => _gen.cancel;
  String get delete => _gen.delete;
  String get deleteConfirmation => _gen.delete_confirmation;
  String get deleteAll => _gen.delete_all;
  String get deleteAllConfirmation => _gen.delete_all_confirmation;
  String get yes => _gen.yes;
  String get no => _gen.no;
  String get menu => _gen.menu;
  String get home => _gen.home;
  String get profile => _gen.profile;
  String get language => _gen.language;
  String get languageSelection => _gen.language_selection;
  String get about => _gen.about;
  String get aboutTitle => _gen.about_title;
  String get aboutAppTitle => _gen.about_app_title;
  String get aboutAppDescription1 => _gen.about_app_description1;
  String get aboutAppDescription2 => _gen.about_app_description2;
  String get visitZumeTraining => _gen.visit_zume_training;
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
    final genDelegate = gen.AppLocalizations.delegate;
    final genLocalizations = await genDelegate.load(locale);
    return AppLocalizations(locale, genLocalizations);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 