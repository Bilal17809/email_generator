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

  /*Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    isLoading.value = true;
    responseText.value = "⏳ Thinking...";

    // 📝 Build instruction string for AI
    final instruction = """
You are an assistant that always writes emails.
The output MUST be in $language only.
Tone: $tone
Length: $length

User's input: "$prompt"
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
  }*/
  Future<bool> callMistral({
    required String prompt,
    required String language,
    required String tone,
    required String length,
  }) async {
    isLoading.value = true;
    responseText.value = "⏳ Thinking...";

    // Step 1: Build email draft instruction
    final instruction = """
You are an assistant that always writes emails.
Tone: $tone
Length: $length

User's input: "$prompt"
""";

    // Step 2: Decide tokens based on length
    final maxTokens = length.toLowerCase() == "short"
        ? 50
        : length.toLowerCase() == "medium"
        ? 100
        : 200;

    try {
      // Step 3: Generate first draft (default, usually English)
      final aiResponse =
      await sendMessageUseCase(instruction, maxTokens: maxTokens);

      // Step 4: If the user chose a non-English language, translate
      if (language.toLowerCase() != "english") {
        final translationPrompt = """
Translate the following email into **$language**.
Only output the translated email text, no explanations.

$aiResponse
""";

        responseText.value =
        await sendMessageUseCase(translationPrompt, maxTokens: 300);
      } else {
        responseText.value = aiResponse;
      }

      return true;
    } catch (e) {
      responseText.value = "❌ Exception: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }

}

