import 'package:get/get.dart';

class WriteMailController extends GetxController {
  var selectedLanguage = "English".obs;
  var searchQuery = "".obs;

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void selectLanguage(String lang) {
    selectedLanguage.value = lang;
    Get.back(); // close bottom sheet
  }
}
