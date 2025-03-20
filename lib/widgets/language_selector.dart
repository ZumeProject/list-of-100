import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/language_service.dart';

/// A reusable language selector bottom sheet
class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLocaleSelected;
  
  const LanguageSelector({
    super.key,
    required this.onLocaleSelected,
  });

  /// Show the language selector as a bottom sheet
  static void show(BuildContext context, Function(Locale)? onLocaleSelected) {
    // Don't show the selector if the callback is null
    if (onLocaleSelected == null) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => LanguageSelector(onLocaleSelected: onLocaleSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
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
  }

  List<Widget> _buildLanguageItems(BuildContext context) {
    final languages = LanguageService().getSortedLanguageList();
    
    return languages.map((language) {
      return ListTile(
        title: Text(language.name),
        onTap: () {
          onLocaleSelected(language.toLocale());
          Navigator.pop(context);
        },
      );
    }).toList();
  }
} 