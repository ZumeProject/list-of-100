import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

class DrawerMenu extends StatelessWidget {
  final Function(Locale)? setLocale;

  const DrawerMenu({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          _buildMenuItem(
            context,
            icon: Icons.home,
            title: localizations.home,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.person,
            title: localizations.profile,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.delete_forever,
            title: localizations.deleteAll,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/delete_all');
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: localizations.about,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.language,
            title: localizations.language,
            onTap: () {
              Navigator.pop(context);
              _showLanguageSelector(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Zúme',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      onTap: onTap,
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
          initialChildSize: 0.6,
          minChildSize: 0.4,
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
      {'code': 'or', 'name': 'ଓଡ଼ିଆ (Odia)'},
      {'code': 'fa', 'name': 'فارسی (Persian)'},
      {'code': 'pl', 'name': 'Polski (Polish)'},
      {'code': 'pt', 'name': 'Português (Portuguese)'},
      {'code': 'pa', 'name': 'ਪੰਜਾਬੀ (Punjabi)'},
      {'code': 'pa_pk', 'name': 'پنجابی (Western Punjabi)'},
      {'code': 'ru', 'name': 'Русский (Russian)'},
      {'code': 'ro', 'name': 'Română (Romanian)'},
      {'code': 'sl', 'name': 'Slovenščina (Slovenian)'},
      {'code': 'so', 'name': 'Soomaali (Somali)'},
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
          if (setLocale != null) {
            setLocale!(Locale(language['code']!));
          }
          Navigator.pop(context);
        },
      );
    }).toList();
  }
} 