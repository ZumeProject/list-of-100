import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import 'language_selector.dart';

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
              LanguageSelector.show(context, setLocale);
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
} 