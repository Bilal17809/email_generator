
String countryCodeToEmoji(String countryCode) {
  return countryCode.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
  );
}


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
  'Punjabi': 'IN',
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