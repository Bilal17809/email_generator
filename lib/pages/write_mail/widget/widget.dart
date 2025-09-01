import 'package:email_generator/core/constant/constant.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';


class WriteMail extends StatefulWidget {
  const WriteMail({super.key});

  @override
  State<WriteMail> createState() => _WriteMailState();
}

class _WriteMailState extends State<WriteMail> {
  String? selectedLanguage; // ✅ Store selected language
  String searchQuery = "";

  /// ✅ Open draggable bottom sheet with languages
  void _openDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // 🔍 Filter languages for "Other Languages"
            final filteredLanguages = languages
                .where(
                  (lang) => lang["name"]!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
                .toList();

            final topLanguages = ["English", "Arabic", "Urdu"];

            final topList = filteredLanguages
                .where((lang) => topLanguages.contains(lang["name"]))
                .toList();
            final otherList = filteredLanguages
                .where((lang) => !topLanguages.contains(lang["name"]))
                .toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.7, // fixed 70%
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // 🔍 Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: context.screenWidth * 0.86,
                      height: context.screenHeight * 0.05,
                      child: TextField(
                        cursorHeight: 15,
                        cursorColor: greetingsColor,
                        onChanged: (value) {
                          setModalState(() {
                            searchQuery = value;
                          });
                        },
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: greetingsColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),

                    ),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView(
                      children: [
                        // ✅ Top Languages
                        if (topList.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "⭐ Top Languages",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...topList.map(
                                (lang) => ListTile(
                              leading: Text(
                                lang["flag"]!,
                                style: const TextStyle(fontSize: 22),
                              ),
                              title: Text(lang["name"]!),
                              trailing: selectedLanguage == lang["name"]
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                setState(() {
                                  selectedLanguage = lang["name"];
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Selected: ${lang["name"]}"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        // ✅ Other Languages (scrollable)
                        if (otherList.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "🌍 Other Languages",
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
                              trailing: selectedLanguage == lang["name"]
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                setState(() {
                                  selectedLanguage = lang["name"];
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Selected: ${lang["name"]}"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Write Mail")),
      body: Center(
        child: InkWell(
          onTap: () => _openDraggableBottomSheet(context), // ✅ works fine
          child: Card(
            color: Colors.pink.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                selectedLanguage == null
                    ? "Select Language"
                    : "Selected: $selectedLanguage",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ Convert country ISO code to emoji flag
String countryCodeToEmoji(String countryCode) {
  return countryCode.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
  );
}

/// ✅ Language data
/// ✅ Language data
final Map<String, String> languageCodes = {
  'English': 'en',
  'French': 'fr',
  'German': 'de',
  'Italian': 'it',
  'Portuguese': 'pt',
  'Dutch': 'nl',
  'Russian': 'ru',
  'Chinese (Simplified)': 'zh-cn',
  'Japanese': 'ja',
  'Korean': 'ko',
  'Arabic': 'ar',
  'Hindi': 'hi',
  'Urdu': 'ur',
  'Punjabi': 'pa',
  'Turkish': 'tr',
  'Thai': 'th',
  'Swedish': 'sv',
  'Ukrainian': 'uk',
};

final Map<String, String> languageFlags = {
  'Arabic': 'AE',
  'Bengali': 'BD',
  'Chinese (Simplified)': 'CN',
  'Czech': 'CZ',
  'Danish': 'DK',
  'Dutch': 'NL',
  'English': 'US',
  'Finnish': 'FI',
  'French': 'FR',
  'German': 'DE',
  'Greek': 'GR',
  'Gujarati': 'IN',
  'Hindi': 'IN',
  'Hungarian': 'HU',
  'Indonesian': 'ID',
  'Italian': 'IT',
  'Japanese': 'JP',
  'Kannada': 'IN',
  'Korean': 'KR',
  'Malay': 'MY',
  'Marathi': 'IN',
  'Norwegian': 'NO',
  'Polish': 'PL',
  'Portuguese': 'PT',
  'Punjabi': 'PK',
  'Romanian': 'RO',
  'Russian': 'RU',
  'Spanish': 'ES',
  'Swahili': 'KE',
  'Swedish': 'SE',
  'Tamil': 'LK',
  'Telugu': 'IN',
  'Thai': 'TH',
  'Turkish': 'TR',
  'Ukrainian': 'UA',
  'Urdu': 'PK',
  'Vietnamese': 'VN',
  'Zulu': 'ZA',
};

/// ✅ Final merged list of languages with flag emojis
final List<Map<String, String>> languages = languageCodes.entries.map((entry) {
  final lang = entry.key;
  final code = entry.value;

  final flagCode = languageFlags[lang] ?? "UN";
  final flag = flagCode == "UN" ? "🏳️" : countryCodeToEmoji(flagCode);

  return {"name": lang, "code": code, "flag": flag};
}).toList();
