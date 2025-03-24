import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import '../widgets/language_selector.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  final Function(Locale)? setLocale;
  
  const AboutScreen({
    super.key,
    this.setLocale,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.aboutTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: localizations.languageSelection,
            onPressed: () => LanguageSelector.show(context, widget.setLocale),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.aboutAppTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              localizations.aboutAppDescription1,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.aboutAppDescription2,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final locale = Localizations.localeOf(context);
                  final langCode = locale.countryCode != null 
                      ? '${locale.languageCode}-${locale.countryCode}'
                      : locale.languageCode;
                  final url = 'https://zume.training/$langCode';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                child: Text(localizations.visitZumeTraining),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 