
import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for managing tone state
class ToneController extends GetxController {
  var searchQuery = "".obs;
  var selectedTone = "Friendly".obs; // default tone

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void select(String tone) {
    selectedTone.value = tone;
    Get.back(); // close bottom sheet after selection
  }
  Future<void> selectTone(String tone) async {
    await saveTone(tone); // ✅ save to SharedPreferences
    selectedTone.value = tone;
    Get.back(); // close bottom sheet
  }

  /// ✅ Save selected tone
  Future<void> saveTone(String tone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedTone", tone);
    selectedTone.value = tone;
    print("✅ Saved Tone: $tone");
  }

  /// ✅ Load saved tone
  Future<void> loadTone() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTone = prefs.getString("selectedTone");
    if (savedTone != null) {
      selectedTone.value = savedTone;
      print("🔄 Loaded Tone: $savedTone");
    }
  }
}

/// Main Widget with Tone Card + Bottom Sheet
class ToneSelector extends StatelessWidget {
  ToneSelector({super.key});

  final ToneController controller = Get.put(ToneController());

  final List<Map<String, String>> tones = [
    {"tone": "Formal", "emoji": "📄"},
    {"tone": "Friendly", "emoji": "🤝"},
    {"tone": "Brutal", "emoji": "💀"},
    {"tone": "Persuasive", "emoji": "🗣️"},
    {"tone": "Confident", "emoji": "💪"},
    {"tone": "Joyful", "emoji": "😃"},
    {"tone": "Creative", "emoji": "🎨"},
    {"tone": "Professional", "emoji": "👔"},
    {"tone": "Casual", "emoji": "😎"},
    {"tone": "Inspirational", "emoji": "🌟"},
    {"tone": "Polite", "emoji": "🙏"},
    {"tone": "Sarcastic", "emoji": "😏"},
  ];

  /// ✅ Bottom Sheet
  void _openDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Obx(() {
          final filteredTones = tones
              .where((tone) => tone["tone"]!
              .toLowerCase()
              .contains(controller.searchQuery.value.toLowerCase()))
              .toList();

          final topTrending = ["Formal", "Friendly"]; // highlight these
          final trendingList = filteredTones
              .where((tone) => topTrending.contains(tone["tone"]))
              .toList();

          final otherList = filteredTones
              .where((tone) => !topTrending.contains(tone["tone"]))
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
                    "Select Tone",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // 🔍 Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    onChanged: controller.updateSearch,

                    decoration: InputDecoration(
                      hintText: "Search tone...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      // ⭐ Top Trending
                      if (trendingList.isNotEmpty) ...[
                        const Text(
                          "Top Trending",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: trendingList
                              .map((tone) => ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tone["emoji"]!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  tone["tone"]!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            selected: controller.selectedTone.value == tone["tone"],

                            // ✅ Background colors
                            backgroundColor: kWhite, // unselected chip
                            selectedColor: greetingsColor, // selected chip

                            // ✅ Rounded corners
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // increase radius here
                            ),

                            // ✅ Text color handling (important if selectedColor is dark)
                            labelStyle: TextStyle(
                              color: controller.selectedTone.value == tone["tone"]
                                  ? Colors.white // selected text color
                                  : Colors.black, // unselected text color
                            ),

                            onSelected: (_) => controller.selectTone(tone["tone"]!),
                          ))

                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // 🌍 Others
                      if (otherList.isNotEmpty) ...[
                        const Text(
                          "Others",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: otherList
                              .map((tone) => ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tone["emoji"]!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  tone["tone"]!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            selected: controller.selectedTone.value == tone["tone"],

                            // ✅ Background colors
                            backgroundColor: kWhite, // unselected state
                            selectedColor: greetingsColor, // selected state

                            // ✅ Rounded corners
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // increase radius here
                            ),

                            // ✅ Text color handling
                            labelStyle: TextStyle(
                              color: controller.selectedTone.value == tone["tone"]
                                  ? Colors.white // when selected
                                  : Colors.black, // when unselected
                            ),

                            onSelected: (_) => controller.selectTone(tone["tone"]!),
                          ))

                              .toList(),
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
    return Obx(
          () {
        // find the selected tone + emoji
        final selectedToneData = tones.firstWhere(
              (tone) => tone["tone"] == controller.selectedTone.value,
          orElse: () => {
            "tone": controller.selectedTone.value,
            "emoji": "🎭" // fallback emoji
          },
        );

        return InkWell(
          onTap: () => _openDraggableBottomSheet(context),
          borderRadius: BorderRadius.circular(12),
          child: Card(
            color: Colors.purple.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tone",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedToneData["emoji"]!, // ✅ emoji
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        selectedToneData["tone"]!, // ✅ tone text
                        style: const TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.play_circle,
                      color: Colors.orange.shade600,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}