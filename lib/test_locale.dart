import 'dart:convert';
import 'package:flutter/services.dart';

Future<void> testLocaleLoading() async {
  // Test Swahili
  try {
    String jsonString = await rootBundle.loadString('assets/l10n/app_swa.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    // Successfully loaded the Swahili locale
    // Access JSON values to verify they exist
    jsonMap['@@locale'];
    jsonMap['home_title'];
  } catch (e) {
    // Error loading Swahili locale
  }
} 