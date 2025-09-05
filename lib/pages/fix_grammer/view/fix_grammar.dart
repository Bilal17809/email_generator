import 'package:email_generator/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/model.dart';

import '../../../core/common/submit_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../write_mail/control/controller.dart';

class FixGrammar extends StatelessWidget {
  FixGrammar({super.key});

  final TextEditingController textController = TextEditingController();
  final WriteMailController controller = Get.find<WriteMailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteEF,
      appBar: Appbar(),
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              SizedBox(
                height: context.screenHeight * 0.25,
                width: double.infinity,
                child: Image.asset("images/769.png", fit: BoxFit.cover),
              ),
            ],
          ),

          // 🟨 Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GrammarLanguage(),
                Container(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.045,
                  color: greetingsColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          "Enter text here",
                          style: TextStyle(color: kWhite, fontSize: 15),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 50,
                              height: 23,
                              decoration: BoxDecoration(
                                color: kWhite,
                                border: Border.all(
                                  color: greetingsColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Paste",
                                  style: TextStyle(
                                    color: greetingsColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Center(
                  child: SizedBox(
                    width: context.screenWidth * 0.9,
                    height: context.screenHeight * 0.5,
                    child: Card(
                      color: kWhite,
                      child: Column(
                        children: [
                          // 🔲 Container gives background + border
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 7),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent, // ✅ background color
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // ✅ rounded corners
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Type your message...",
                                  border: InputBorder.none,
                                  // 🚫 no TextField border
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ),

                          // 🎤 Mic at bottom
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🟥 Button fixed at bottom (always on top)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.1,
            child: SubmitButtonBar(
              text: "Submit",
              greetingsColor: Colors.blue,
              kWhite: Colors.white,
              textController: textController, // 🔥 shared
            ),
          ),
        ],
      ),
    );
  }
}

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteEF,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back_rounded, color: greetingsColor, size: 30),
      ),
      title: Text("Fix Grammar", style: TextStyle(color: greetingsColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class GrammarLanguage extends StatelessWidget {
  final WriteMailController controller = Get.find<WriteMailController>();

  GrammarLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDraggableBottomSheet(context),
      borderRadius: BorderRadius.circular(12),
      child: Center(
        child: SizedBox(
          width: context.screenWidth * 0.95,
          height: context.screenHeight * 0.13,
          child: Card(
            color: Colors.pink.shade50,
            child: Obx(() {
              final lang = languages.firstWhere(
                (l) => l["name"] == controller.selectedLanguage.value,
              );
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Language",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: kWhite,
                        child: Text(
                          lang["flag"]!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          controller.selectedLanguage.value,
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Spacer(),
                      const Icon(
                        Icons.play_circle,
                        color: Colors.pinkAccent,
                        size: 25,
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
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
              .where(
                (lang) =>
                    lang["name"] != controller.selectedLanguage.value &&
                    lang["name"]!.toLowerCase().contains(
                      controller.searchQuery.value.toLowerCase(),
                    ),
              )
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
                          selected["name"]!.toLowerCase().contains(
                            controller.searchQuery.value.toLowerCase(),
                          )) ...[
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
                          leading: Text(
                            selected["flag"]!,
                            style: const TextStyle(fontSize: 22),
                          ),
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
                            leading: Text(
                              lang["flag"]!,
                              style: const TextStyle(fontSize: 22),
                            ),
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
