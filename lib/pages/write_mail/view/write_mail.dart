
import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../control/controller.dart';
import '../widget/widget.dart';

class WriteMail extends StatelessWidget {
  WriteMail({super.key});

  final WriteMailController controller = Get.put(WriteMailController());

  /// ✅ Open draggable bottom sheet with languages
  void _openDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Obx(() {
          final filteredLanguages = languages
              .where((lang) => lang["name"]!
              .toLowerCase()
              .contains(controller.searchQuery.value.toLowerCase()))
              .toList();

          final topLanguages = ["English", "Arabic", "Urdu"];
          final topList = filteredLanguages
              .where((lang) => topLanguages.contains(lang["name"]))
              .toList();
          final otherList = filteredLanguages
              .where((lang) => !topLanguages.contains(lang["name"]))
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

                // 🔍 Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: context.width * 0.86,
                    height: context.height * 0.05,
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
                              color: greetingsColor, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: greetingsColor, width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView(
                    children: [
                      if (topList.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("⭐ Top Languages",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        ...topList.map(
                              (lang) => ListTile(
                            leading: Text(lang["flag"]!,
                                style: const TextStyle(fontSize: 22)),
                            title: Text(lang["name"]!),
                            trailing:
                            controller.selectedLanguage.value ==
                                lang["name"]
                                ? const Icon(Icons.circle,
                                size: 10, color: Colors.green)
                                : null,
                            onTap: () =>
                                controller.selectLanguage(lang["name"]!),
                          ),
                        ),
                      ],
                      if (otherList.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("🌍 Other Languages",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        ...otherList.map(
                              (lang) => ListTile(
                            leading: Text(lang["flag"]!,
                                style: const TextStyle(fontSize: 22)),
                            title: Text(lang["name"]!),
                            trailing:
                            controller.selectedLanguage.value ==
                                lang["name"]
                                ? const Icon(Icons.circle,
                                size: 10, color: Colors.green)
                                : null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_rounded,
              color: greetingsColor, size: 30),
        ),
        title: Text("Write Mail", style: TextStyle(color: greetingsColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // ✅ Language Card
            InkWell(
              onTap: () => _openDraggableBottomSheet(context),
              borderRadius: BorderRadius.circular(12),
              child: Card(
                color: Colors.pink.shade50,
                child: Center(
                  child: Obx(() {
                    final lang = languages.firstWhere(
                            (l) => l["name"] == controller.selectedLanguage.value);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Language",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(lang["flag"]!,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                controller.selectedLanguage.value,
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.play_circle,
                                color: Colors.pinkAccent, size: 18),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            // ✅ Tone Card (static for now)
            Card(
              color: Colors.purple.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tone",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Friendly", style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 3),
                      Icon(Icons.play_circle,
                          color: Colors.orange.shade600, size: 18),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ Length Card (static for now)
            Card(
              color: Colors.blue.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Length",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Medium", style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 3),
                      Icon(Icons.play_circle,
                          color: Colors.red.shade200, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
