import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for managing tone state
class ToneController extends GetxController {
  var searchQuery = "".obs;
  var selectedTone = "Friendly".obs; // default tone
  final searchTextController = TextEditingController().obs;
  final List<String> toneSuggestions = [
    "Formal",
    "Friendly",
    "Professional",
    "Casual",
    "Informative",
    "Persuasive",
    "Encouraging",
    "Neutral",
    "Confident",
    "Enthusiastic"
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchTextController.value.text = searchQuery.value;
  }

  var searchSuggestions = <String>[].obs;

  void updateSearch(String query) {
    searchQuery.value = query;

    // Update search suggestions based on query
    if (query.isNotEmpty) {
      searchSuggestions.value = toneSuggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      searchSuggestions.value = [];
    }
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
  void _openDraggableBottomSheet(BuildContext context) {
    // Clear the search query when opening the bottom sheet
    controller.updateSearch('');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Obx(() {
          // Filter tones based on search query
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: TextField(
                //     controller: TextEditingController(text: controller.searchQuery.value),
                //     onChanged: controller.updateSearch,
                //     decoration: InputDecoration(
                //       hintText: "Search tone...",
                //       prefixIcon: const Icon(Icons.search),
                //       filled: true,
                //       fillColor: Colors.grey.shade100,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller:controller.searchTextController.value,
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

                // Show search suggestions if available
              /*  if (controller.searchSuggestions.isNotEmpty &&
                    controller.searchQuery.value.isNotEmpty)
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: controller.searchSuggestions
                          .map((suggestion) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.updateSearch(suggestion);
                          },
                          child: Chip(
                            label: Text(suggestion),
                            backgroundColor: Colors.blue.shade100,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),*/
                // Scrollable vertical chip list


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
                            backgroundColor: Colors.white, // unselected chip
                            selectedColor: Colors.blue, // selected chip

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

                            onSelected: (_) {
                              controller.selectTone(tone["tone"]!);
                              // Navigator.pop(context); // Close the bottom sheet after selection
                            },
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
                            backgroundColor: Colors.white, // unselected state
                            selectedColor: Colors.blue, // selected state

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

                            onSelected: (_) {
                              controller.selectTone(tone["tone"]!);
                              // Navigator.pop(context); // Close the bottom sheet after selection
                            },
                          ))
                              .toList(),
                        ),
                      ],

                      // Show message if no tones match search
                      if (filteredTones.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "No tones found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
  /// ✅ Bottom Sheet
  // void _openDraggableBottomSheet(BuildContext context) {
  //   controller.updateSearch('');
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (_) {
  //       return Obx(() {
  //         final filteredTones = tones
  //             .where((tone) => tone["tone"]!
  //             .toLowerCase()
  //             .contains(controller.searchQuery.value.toLowerCase()))
  //             .toList();
  //
  //         final topTrending = ["Formal", "Friendly"]; // highlight these
  //         final trendingList = filteredTones
  //             .where((tone) => topTrending.contains(tone["tone"]))
  //             .toList();
  //
  //         final otherList = filteredTones
  //             .where((tone) => !topTrending.contains(tone["tone"]))
  //             .toList();
  //
  //         return Container(
  //           height: MediaQuery.of(context).size.height * 0.7,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
  //           ),
  //           child: Column(
  //             children: [
  //               const Padding(
  //                 padding: EdgeInsets.all(12.0),
  //                 child: Text(
  //                   "Select Tone",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //
  //               // 🔍 Search bar
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: TextField(
  //                   onChanged: controller.updateSearch,
  //
  //                   decoration: InputDecoration(
  //                     hintText: "Search tone...",
  //                     prefixIcon: const Icon(Icons.search),
  //                     filled: true,
  //                     fillColor: Colors.grey.shade100,
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //               const SizedBox(height: 12),
  //
  //               Expanded(
  //                 child: ListView(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16),
  //                   children: [
  //                     // ⭐ Top Trending
  //                     if (trendingList.isNotEmpty) ...[
  //                       const Text(
  //                         "Top Trending",
  //                         style:
  //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Wrap(
  //                         spacing: 8,
  //                         runSpacing: 8,
  //                         children: trendingList
  //                             .map((tone) => ChoiceChip(
  //                           label: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text(
  //                                 tone["emoji"]!,
  //                                 style: const TextStyle(fontSize: 18),
  //                               ),
  //                               const SizedBox(width: 6),
  //                               Text(
  //                                 tone["tone"]!,
  //                                 style: const TextStyle(fontSize: 14),
  //                               ),
  //                             ],
  //                           ),
  //                           selected: controller.selectedTone.value == tone["tone"],
  //
  //                           // ✅ Background colors
  //                           backgroundColor: kWhite, // unselected chip
  //                           selectedColor: greetingsColor, // selected chip
  //
  //                           // ✅ Rounded corners
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(30), // increase radius here
  //                           ),
  //
  //                           // ✅ Text color handling (important if selectedColor is dark)
  //                           labelStyle: TextStyle(
  //                             color: controller.selectedTone.value == tone["tone"]
  //                                 ? Colors.white // selected text color
  //                                 : Colors.black, // unselected text color
  //                           ),
  //
  //                           onSelected: (_) => controller.selectTone(tone["tone"]!),
  //                         ))
  //
  //                             .toList(),
  //                       ),
  //                       const SizedBox(height: 16),
  //                     ],
  //
  //                     // 🌍 Others
  //                     if (otherList.isNotEmpty) ...[
  //                       const Text(
  //                         "Others",
  //                         style:
  //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Wrap(
  //                         spacing: 8,
  //                         runSpacing: 8,
  //                         children: otherList
  //                             .map((tone) => ChoiceChip(
  //                           label: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text(
  //                                 tone["emoji"]!,
  //                                 style: const TextStyle(fontSize: 18),
  //                               ),
  //                               const SizedBox(width: 6),
  //                               Text(
  //                                 tone["tone"]!,
  //                                 style: const TextStyle(fontSize: 14),
  //                               ),
  //                             ],
  //                           ),
  //                           selected: controller.selectedTone.value == tone["tone"],
  //
  //                           // ✅ Background colors
  //                           backgroundColor: kWhite, // unselected state
  //                           selectedColor: greetingsColor, // selected state
  //
  //                           // ✅ Rounded corners
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(25), // increase radius here
  //                           ),
  //
  //                           // ✅ Text color handling
  //                           labelStyle: TextStyle(
  //                             color: controller.selectedTone.value == tone["tone"]
  //                                 ? Colors.white // when selected
  //                                 : Colors.black, // when unselected
  //                           ),
  //
  //                           onSelected: (_) => controller.selectTone(tone["tone"]!),
  //                         ))
  //
  //                             .toList(),
  //                       ),
  //                     ],
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }


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