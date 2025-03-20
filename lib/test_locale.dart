import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> testLocaleLoading() async {
  print('Starting locale test...');
  
  // Test Swahili
  try {
    print('Testing Swahili (swa) locale...');
    String jsonString = await rootBundle.loadString('assets/l10n/app_swa.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    print('Swahili locale loaded successfully!');
    print('@@locale: ${jsonMap['@@locale']}');
    print('Sample key (home_title): ${jsonMap['home_title']}');
  } catch (e) {
    print('Error loading Swahili locale: $e');
  }
  
  print('Test complete!');
} 