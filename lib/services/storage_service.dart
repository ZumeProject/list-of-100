import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';

class StorageService extends ChangeNotifier {
  final SharedPreferences _prefs;
  final String _peopleKey = 'zume_people_list';
  List<Person> _people = [];

  StorageService(this._prefs) {
    _loadPeople();
  }

  List<Person> get people => _people;

  Future<void> _loadPeople() async {
    final String? peopleString = _prefs.getString(_peopleKey);
    
    if (peopleString != null) {
      try {
        final List<dynamic> peopleJson = jsonDecode(peopleString);
        _people = peopleJson.map((json) => Person.fromJson(json)).toList();
      } catch (e) {
        // If there's an error with the stored data, initialize with empty list
        _people = [];
      }
    }
    
    notifyListeners();
  }

  Future<void> _savePeople() async {
    final List<Map<String, dynamic>> peopleJson = _people.map((person) => person.toJson()).toList();
    await _prefs.setString(_peopleKey, jsonEncode(peopleJson));
    notifyListeners();
  }

  Future<void> addPerson(String name, Status status) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final person = Person(id: id, name: name, status: status);
    
    _people.add(person);
    await _savePeople();
  }

  Future<void> updatePerson(String id, {String? name, Status? status}) async {
    final index = _people.indexWhere((person) => person.id == id);
    
    if (index != -1) {
      _people[index] = _people[index].copyWith(
        name: name,
        status: status,
      );
      
      await _savePeople();
    }
  }

  Future<void> removePerson(String id) async {
    _people.removeWhere((person) => person.id == id);
    await _savePeople();
  }

  Future<void> clearAllPeople() async {
    _people.clear();
    await _savePeople();
  }
} 