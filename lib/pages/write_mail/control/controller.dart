import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteMailController extends GetxController {
  var searchQuery = "".obs;
  RxString selectedLanguage = "English".obs; // default language

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  /// Save selected language to SharedPreferences
  Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedLanguage", lang);
    selectedLanguage.value = lang;
    print("✅ Saved Language: $lang");
  }

  /// Load language from SharedPreferences
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString("selectedLanguage");
    if (savedLang != null) {
      selectedLanguage.value = savedLang;
      print("🔄 Loaded Language: $savedLang");
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void selectLanguage(String lang) async {
    await saveLanguage(lang); // ✅ fixed
    Get.back();
  }
}
