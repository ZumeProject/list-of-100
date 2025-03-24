import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/person.dart';
import '../services/storage_service.dart';
import '../utils/app_theme.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/person_tile.dart';
import '../widgets/add_person_form.dart';
import '../widgets/language_selector.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale)? setLocale;

  const HomeScreen({super.key, this.setLocale});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  Status _selectedStatus = Status.unknown;
  String? _editingPersonId;
  Status? _filterStatus;
  bool _sortAscending = true;

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
            isEditing: true,
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
            onDelete: () {
              _deletePerson(person.id);
              Navigator.pop(context);
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

  void _deletePerson(String id) {
    final storageService = Provider.of<StorageService>(context, listen: false);
    storageService.removePerson(id);
    _resetForm();
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _selectedStatus = Status.unknown;
      _editingPersonId = null;
    });
  }

  List<Person> _getFilteredAndSortedPeople(List<Person> people) {
    return List.from(people)
      ..removeWhere((person) => _filterStatus != null && person.status != _filterStatus)
      ..sort((a, b) => _sortAscending 
        ? a.name.compareTo(b.name)
        : b.name.compareTo(a.name));
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
            icon: Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
            tooltip: _sortAscending ? 'Sort A-Z' : 'Sort Z-A',
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: localizations.languageSelection,
            onPressed: () => LanguageSelector.show(context, widget.setLocale),
          ),
        ],
      ),
      drawer: DrawerMenu(setLocale: widget.setLocale),
      body: Column(
        children: [
          _buildStatusCounter(storageService.people),
          Expanded(
            child: _buildPeopleList(_getFilteredAndSortedPeople(storageService.people)),
          ),
          _buildAddPersonTile(),
        ],
      ),
    );
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
            Status.unbeliever,
          ),
          _buildCounterItem(
            AppLocalizations.of(context).believer, 
            believers, 
            total,
            AppTheme.successColor,
            Status.believer,
          ),
          _buildCounterItem(
            AppLocalizations.of(context).unknown, 
            unknowns, 
            total,
            Colors.grey,
            Status.unknown,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterItem(String label, int count, int total, Color color, Status status) {
    final percentage = total > 0 ? (count / total * 100).toInt() : 0;
    final isSelected = _filterStatus == status;
    
    return InkWell(
      onTap: () {
        setState(() {
          _filterStatus = isSelected ? null : status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 25) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.check, size: 16),
                ],
              ],
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
        ),
      ),
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