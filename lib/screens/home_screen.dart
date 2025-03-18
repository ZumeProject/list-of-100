import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/person.dart';
import '../services/storage_service.dart';
import '../utils/app_theme.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/person_tile.dart';
import '../widgets/add_person_form.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  const HomeScreen({super.key, required this.setLocale});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  Status _selectedStatus = Status.unknown;
  String? _editingPersonId;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showAddPersonDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddPersonForm(
            nameController: _nameController,
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
            onSave: () {
              _savePerson();
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
              _resetForm();
            },
          ),
        );
      },
    );
  }

  void _showEditPersonDialog(Person person) {
    setState(() {
      _editingPersonId = person.id;
      _nameController.text = person.name;
      _selectedStatus = person.status;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddPersonForm(
            nameController: _nameController,
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
            onSave: () {
              _savePerson();
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
              _resetForm();
            },
          ),
        );
      },
    );
  }

  void _savePerson() {
    final storageService = Provider.of<StorageService>(context, listen: false);
    
    if (_nameController.text.trim().isNotEmpty) {
      if (_editingPersonId != null) {
        storageService.updatePerson(
          _editingPersonId!,
          name: _nameController.text.trim(),
          status: _selectedStatus,
        );
      } else {
        storageService.addPerson(
          _nameController.text.trim(),
          _selectedStatus,
        );
      }
      
      _resetForm();
    }
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _selectedStatus = Status.unknown;
      _editingPersonId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final storageService = Provider.of<StorageService>(context);
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.homeTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            tooltip: localizations.languageSelection,
            onPressed: () => _showLanguageSelector(context),
          ),
        ],
      ),
      drawer: DrawerMenu(setLocale: widget.setLocale),
      body: Column(
        children: [
          _buildStatusCounter(storageService.people),
          Expanded(
            child: _buildPeopleList(storageService.people),
          ),
          _buildAddPersonTile(),
        ],
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
          widget.setLocale(Locale(language['code']!));
          Navigator.pop(context);
        },
      );
    }).toList();
  }

  Widget _buildStatusCounter(List<Person> people) {
    final unbelievers = people.where((p) => p.status == Status.unbeliever).length;
    final believers = people.where((p) => p.status == Status.believer).length;
    final unknowns = people.where((p) => p.status == Status.unknown).length;
    final total = people.length;
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.primaryLighterColor.withValues(alpha: 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCounterItem(
            AppLocalizations.of(context).unbeliever, 
            unbelievers, 
            total,
            AppTheme.errorColor,
          ),
          _buildCounterItem(
            AppLocalizations.of(context).believer, 
            believers, 
            total,
            AppTheme.successColor,
          ),
          _buildCounterItem(
            AppLocalizations.of(context).unknown, 
            unknowns, 
            total,
            Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterItem(String label, int count, int total, Color color) {
    final percentage = total > 0 ? (count / total * 100).toInt() : 0;
    
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '$count ($percentage%)',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPeopleList(List<Person> people) {
    if (people.isEmpty) {
      return Center(
        child: Text(
          'Your list is empty.\nAdd people to get started.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: people.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final person = people[index];
        return PersonTile(
          person: person,
          onTap: () => _showEditPersonDialog(person),
        );
      },
    );
  }

  Widget _buildAddPersonTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: _showAddPersonDialog,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).addPersonHint,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 