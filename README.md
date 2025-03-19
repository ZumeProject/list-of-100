# zume_list_of_100

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Language Handling Rules

This app follows these guidelines for handling language codes and localization:

1. **Do not change language codes without explicit request**
   - The language codes should match the exact filename patterns in assets/l10n/
   - Example: Use 'zhhk' rather than 'zh' with country code 'HK' unless specifically requested

2. **Preserve existing @@locale values**
   - Never modify the @@locale property in existing JSON files
   - When adding new language files, use the filename-based convention

3. **Use filename-based direct access**
   - Direct matches should use the filename pattern (e.g., 'pa_pk' not 'pa' with country code 'PK')
   - This maintains consistency between file organization and code

## Building and Running
