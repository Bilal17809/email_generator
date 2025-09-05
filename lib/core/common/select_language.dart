import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/write_mail/control/controller.dart';
import '../theme/app_colors.dart';
import 'model.dart';

 // ✅ adjust path

class LanguageSelector extends StatelessWidget {

  final WriteMailController controller = Get.find<WriteMailController>();

  LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDraggableBottomSheet(context),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: Colors.pink.shade50,
        child: Center(
          child: Obx(() {
            final lang = languages.firstWhere(
                  (l) => l["name"] == controller.selectedLanguage.value,
            );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Language",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lang["flag"]!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        controller.selectedLanguage.value,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.play_circle,
                      color: Colors.pinkAccent,
                      size: 18,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
  void _openDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Obx(() {
          // Get selected language
          final selected = languages.firstWhereOrNull(
                (lang) => lang["name"] == controller.selectedLanguage.value,
          );

          // Filter other languages based on search query, excluding selected
          final otherList = languages
              .where((lang) =>
          lang["name"] != controller.selectedLanguage.value &&
              lang["name"]!
                  .toLowerCase()
                  .contains(controller.searchQuery.value.toLowerCase()))
              .toList();

          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Select language",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Search field
                SizedBox(
                  width: context.width * 0.86,
                  height: 50,
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: InputDecoration(
                      hintText: "Search language...",
                      prefixIcon: Icon(Icons.search, color: greetingsColor),
                      filled: true,
                      fillColor: kWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: greetingsColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Scrollable list
                Expanded(
                  child: ListView(
                    children: [
                      // Show selected language on top if exists
                      if (selected != null &&
                          selected["name"]!
                              .toLowerCase()
                              .contains(controller.searchQuery.value.toLowerCase())) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Selected Language",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Text(selected["flag"]!,
                              style: const TextStyle(fontSize: 22)),
                          title: Text(selected["name"]!),
                          trailing: const Icon(
                            Icons.check_circle,
                            size: 18,
                            color: Colors.green,
                          ),
                          onTap: () =>
                              controller.selectLanguage(selected["name"]!),
                        ),
                        const SizedBox(height: 10),
                      ],

                      // Show other languages
                      if (otherList.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Other Languages",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...otherList.map(
                              (lang) => ListTile(
                            leading: Text(lang["flag"]!,
                                style: const TextStyle(fontSize: 22)),
                            title: Text(lang["name"]!),
                            onTap: () =>
                                controller.selectLanguage(lang["name"]!),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }


}
