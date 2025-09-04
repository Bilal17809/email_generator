
import 'package:get/get.dart';


/*class MistralController extends GetxController {
  var responseText = "Type something and press Ask Mistral...".obs;
  var isLoading = false.obs;



  Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    final url = Uri.parse(EnvironmentConfig.baseUrl);

    final headers = {
      "Authorization": "Bearer ${ApiRoutes.apiKey}",
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
          ? 75
          : length == "medium"
          ? 150
          : 300,
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
}*/



import '../../../domain/usecases/send_message_usecase.dart';


class MistralController extends GetxController {
  var responseText = "Type something and press Ask Mistral...".obs;
  var isLoading = false.obs;

  final SendMessageUseCase sendMessageUseCase;

  MistralController(this.sendMessageUseCase);

  Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    isLoading.value = true;
    responseText.value = "⏳ Thinking...";

    // Build instruction string
    final instruction =
        "Write in $language with a $tone tone and $length length. "
        "Here is the content: $prompt";

    // Decide maxTokens based on length
    final maxTokens = length == "short"
        ? 50
        : length == "medium"
        ? 100
        : 200;

    try {
      // ✅ Call the use case
      final aiResponse = await sendMessageUseCase.call(instruction, maxTokens: maxTokens);

      responseText.value = aiResponse;
      return true;
    } catch (e) {
      responseText.value = "Exception: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}


