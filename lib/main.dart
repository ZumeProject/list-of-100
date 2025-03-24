import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as gen;
import 'screens/home_screen.dart';
import 'screens/delete_all_screen.dart';
import 'screens/about_screen.dart';
import 'services/storage_service.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => storageService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zúme List of 100',
      theme: AppTheme.lightTheme,
      locale: _locale,
      localizationsDelegates: [
        gen.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: gen.AppLocalizations.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        if (locales == null || locales.isEmpty) {
          return const Locale('en');
        }
        
        final Locale requestedLocale = locales.first;
        
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == requestedLocale.languageCode) {
            if (supportedLocale.countryCode == requestedLocale.countryCode) {
              return requestedLocale;
            }
          }
        }
        
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == requestedLocale.languageCode) {
            return supportedLocale;
          }
        }
        
        return const Locale('en');
      },
      home: HomeScreen(setLocale: setLocale),
      routes: {
        '/home': (context) => HomeScreen(setLocale: setLocale),
        '/delete_all': (context) => DeleteAllScreen(setLocale: setLocale),
        '/about': (context) => AboutScreen(setLocale: setLocale),
      },
    );
  }
}
