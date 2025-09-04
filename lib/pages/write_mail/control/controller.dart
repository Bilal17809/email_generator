import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteMailController extends GetxController {
  var searchQuery = "".obs;
  RxString selectedLanguage = "English".obs;
  final searchTextController = TextEditingController().obs;// default language

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
    searchTextController.value.text = searchQuery.value;
  }

  /// Save selected language to SharedPreferences
  Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedLanguage", lang);
    selectedLanguage.value = lang;
    log("✅ Saved Language: $lang");
  }

  /// Load language from SharedPreferences
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString("selectedLanguage");
    if (savedLang != null) {
      selectedLanguage.value = savedLang;
      log("🔄 Loaded Language: $savedLang");
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
  void selectLanguage(String langName ) {
    selectedLanguage.value = langName;


    /// Clear search
    searchQuery.value = "";
    searchTextController.value.clear();

    /// Close bottom sheet
    Get.back();
  }
}
