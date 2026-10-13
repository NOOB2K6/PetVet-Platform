import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/pet.dart';

class PetService {
  static const String _key = 'pets';

  Future<List<Pet>> getPets() async {
    final prefs = SharedPreferencesAsync();

    final data = await prefs.getString(_key);

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(data);

    return jsonList.map((json) => Pet.fromJson(json)).toList();
  }

  Future<void> savePets(List<Pet> pets) async {
    final prefs = SharedPreferencesAsync();

    final data = jsonEncode(pets.map((pet) => pet.toJson()).toList());

    await prefs.setString(_key, data);
  }

  Future<void> addPet(Pet pet) async {
    final pets = await getPets();

    pets.add(pet);

    await savePets(pets);
  }

  Future<void> deletePet(String id) async {
    final pets = await getPets();

    pets.removeWhere((pet) => pet.id == id);

    await savePets(pets);
  }
}
