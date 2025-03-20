import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../utils/app_theme.dart';
import '../widgets/language_selector.dart';

class DeleteAllScreen extends StatefulWidget {
  final Function(Locale)? setLocale;
  
  const DeleteAllScreen({
    super.key,
    this.setLocale,
  });

  @override
  State<DeleteAllScreen> createState() => _DeleteAllScreenState();
}

class _DeleteAllScreenState extends State<DeleteAllScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.deleteAllTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: localizations.languageSelection,
            onPressed: () => LanguageSelector.show(context, widget.setLocale),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 80,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 24),
            Text(
              localizations.deleteAllConfirmation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(localizations.no),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorColor,
                  ),
                  onPressed: () {
                    _confirmDeleteAll(context);
                  },
                  child: Text(localizations.yes),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteAll(BuildContext context) {
    final storageService = Provider.of<StorageService>(context, listen: false);
    storageService.clearAllPeople();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).deleteAll),
        backgroundColor: AppTheme.successColor,
      ),
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
} 