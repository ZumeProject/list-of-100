import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/person.dart';
import '../utils/app_theme.dart';

class AddPersonForm extends StatefulWidget {
  final TextEditingController nameController;
  final Status selectedStatus;
  final Function(Status) onStatusChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback? onDelete;
  final bool isEditing;

  const AddPersonForm({
    super.key,
    required this.nameController,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.onSave,
    required this.onCancel,
    this.onDelete,
    this.isEditing = false,
  });

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  late Status _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localizations.addPersonHint,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: widget.nameController,
            decoration: InputDecoration(
              hintText: localizations.addPersonHint,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => widget.onSave(),
          ),
          const SizedBox(height: 16),
          Text(
            'Status:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildStatusRadio(
            context,
            Status.unbeliever,
            localizations.unbeliever,
            AppTheme.errorColor,
          ),
          _buildStatusRadio(
            context,
            Status.believer,
            localizations.believer,
            AppTheme.successColor,
          ),
          _buildStatusRadio(
            context,
            Status.unknown,
            localizations.unknown,
            Colors.grey,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.isEditing && widget.onDelete != null) 
                TextButton.icon(
                  onPressed: _showDeleteConfirmation,
                  icon: Icon(Icons.delete, color: AppTheme.errorColor),
                  label: Text(
                    localizations.delete,
                    style: TextStyle(color: AppTheme.errorColor),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: widget.onCancel,
                child: Text(localizations.cancel),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: widget.onSave,
                child: Text(localizations.save),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    final localizations = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.delete),
        content: Text(localizations.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(),
            child: Text(localizations.no),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              if (widget.onDelete != null) {
                widget.onDelete!();
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: Text(localizations.yes),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRadio(
    BuildContext context,
    Status status,
    String label,
    Color color,
  ) {
    return RadioListTile<Status>(
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: status,
      groupValue: _selectedStatus,
      activeColor: color,
      onChanged: (Status? value) {
        if (value != null) {
          setState(() {
            _selectedStatus = value;
          });
          widget.onStatusChanged(value);
        }
      },
    );
  }
} 