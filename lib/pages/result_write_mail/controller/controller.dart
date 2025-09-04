
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MistralController extends GetxController {
  var responseText = "Type something and press Ask Mistral...".obs;
  var isLoading = false.obs;



  Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    final url = Uri.parse("https://api.mistral.ai/v1/chat/completions");

    final headers = {
      "Authorization": "Bearer 0zonSPwAyXd4g8K7JeIg8tFQQe0TEEQe",
      "Content-Type": "application/json",
    };

    final instruction =
        "Write in $language with a $tone tone and $length length. "
        "Here is the content: $prompt";

    final body = jsonEncode({
      "model": "mistral-large-latest",
      "messages": [
        {"role": "user", "content": instruction}
      ],
      "temperature": 0.7,
      "max_tokens": length == "short"
          ? 100
          : length == "medium"
          ? 250
          : 500,
    });

    isLoading.value = true;
    responseText.value = "⏳ Thinking...";

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        responseText.value = data["choices"][0]["message"]["content"];
        print("✅ Success: ${responseText.value}");
        return true;
      } else {
        print("❌ Error Response: ${response.body}");
        responseText.value = "Error: ${response.statusCode}\n${response.body}";
        return false;
      }
    } catch (e) {
      responseText.value = "Exception: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}



