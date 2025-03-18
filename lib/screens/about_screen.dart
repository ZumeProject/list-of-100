import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

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
            onPressed: () => _showLanguageSelector(context),
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
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context).languageSelection,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: _buildLanguageItems(context),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildLanguageItems(BuildContext context) {
    // All supported languages
    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'am', 'name': 'አማርኛ (Amharic)'},
      {'code': 'ar', 'name': 'العربية (Arabic)'},
      {'code': 'hy', 'name': 'Հայերեն (Armenian)'},
      {'code': 'asl', 'name': 'American Sign Language'},
      {'code': 'bn', 'name': 'বাংলা (Bengali)'},
      {'code': 'bho', 'name': 'भोजपुरी (Bhojpuri)'},
      {'code': 'bs', 'name': 'Bosanski (Bosnian)'},
      {'code': 'my', 'name': 'မြန်မာ (Burmese)'},
      {'code': 'zhhk', 'name': '廣東話 (Cantonese)'},
      {'code': 'zhcn', 'name': '简体中文 (Chinese Simplified)'},
      {'code': 'zhtw', 'name': '繁體中文 (Chinese Traditional)'},
      {'code': 'hr', 'name': 'Hrvatski (Croatian)'},
      {'code': 'fr', 'name': 'Français (French)'},
      {'code': 'de', 'name': 'Deutsch (German)'},
      {'code': 'gu', 'name': 'ગુજરાતી (Gujarati)'},
      {'code': 'ha', 'name': 'Hausa'},
      {'code': 'hi', 'name': 'हिन्दी (Hindi)'},
      {'code': 'id', 'name': 'Bahasa Indonesia (Indonesian)'},
      {'code': 'it', 'name': 'Italiano (Italian)'},
      {'code': 'ja', 'name': '日本語 (Japanese)'},
      {'code': 'kn', 'name': 'ಕನ್ನಡ (Kannada)'},
      {'code': 'ko', 'name': '한국어 (Korean)'},
      {'code': 'ku', 'name': 'Kurdî (Kurdish)'},
      {'code': 'lo', 'name': 'ລາວ (Lao)'},
      {'code': 'mai', 'name': 'मैथिली (Maithili)'},
      {'code': 'ml', 'name': 'മലയാളം (Malayalam)'},
      {'code': 'mr', 'name': 'मराठी (Marathi)'},
      {'code': 'ne', 'name': 'नेपाली (Nepali)'},
      {'code': 'fa', 'name': 'فارسی (Persian)'},
      {'code': 'pl', 'name': 'Polski (Polish)'},
      {'code': 'pt', 'name': 'Português (Portuguese)'},
      {'code': 'pa', 'name': 'ਪੰਜਾਬੀ (Punjabi)'},
      {'code': 'pa_pk', 'name': 'پنجابی (Western Punjabi)'},
      {'code': 'ru', 'name': 'Русский (Russian)'},
      {'code': 'ro', 'name': 'Română (Romanian)'},
      {'code': 'es', 'name': 'Español (Spanish)'},
      {'code': 'swa', 'name': 'Kiswahili (Swahili)'},
      {'code': 'ta', 'name': 'தமிழ் (Tamil)'},
      {'code': 'te', 'name': 'తెలుగు (Telugu)'},
      {'code': 'th', 'name': 'ไทย (Thai)'},
      {'code': 'tr', 'name': 'Türkçe (Turkish)'},
      {'code': 'ur', 'name': 'اردو (Urdu)'},
      {'code': 'vi', 'name': 'Tiếng Việt (Vietnamese)'},
      {'code': 'yo', 'name': 'Yorùbá (Yoruba)'}
    ];

    // Sort the languages alphabetically by name
    languages.sort((a, b) => a['name']!.compareTo(b['name']!));
    
    // Move English to the top
    languages.removeWhere((lang) => lang['code'] == 'en');
    languages.insert(0, {'code': 'en', 'name': 'English'});

    return languages.map((language) {
      return ListTile(
        title: Text(language['name']!),
        onTap: () {
          if (widget.setLocale != null) {
            widget.setLocale!(Locale(language['code']!));
          }
          Navigator.pop(context);
        },
      );
    }).toList();
  }
} 