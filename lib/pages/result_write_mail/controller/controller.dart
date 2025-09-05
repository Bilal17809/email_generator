/*

import 'package:get/get.dart';
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
*/

import 'package:get/get.dart';
import '../../../domain/usecases/send_message_usecase.dart';

class MistralController extends GetxController {
  var responseText = "Type something and press Ask Mistral...".obs;
  var isLoading = false.obs;

  final SendMessageUseCase sendMessageUseCase;

  // Inject the use case via constructor
  MistralController(this.sendMessageUseCase);

  Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    isLoading.value = true;
    responseText.value = "⏳ Thinking...";

    final instruction = """
You are an AI email writing assistant.
  
Your task:
- Rewrite the user’s draft into a full, natural, professional email.  
- Always write the ENTIRE email in the $language language (do not use English).  
- Use a $tone tone.  
- Length should be $length (Short ≈ 50 words, Medium ≈ 100 words, Long ≈ 200 words).  

User’s draft:
"$prompt"
""";


    // 🎚 Decide maxTokens based on length
    final maxTokens = length.toLowerCase() == "short"
        ? 50
        : length.toLowerCase() == "medium"
        ? 100
        : 200;

    try {
      // ✅ Call the use case
      final aiResponse =
      await sendMessageUseCase(instruction, maxTokens: maxTokens);

      responseText.value = aiResponse;
      return true;
    } catch (e) {
      responseText.value = "❌ Exception: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }


}

