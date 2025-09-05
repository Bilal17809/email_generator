/*
import '../../core/network/api_client.dart';

class MistralRemoteDataSource {
  final ApiClient _apiClient;

  MistralRemoteDataSource(this._apiClient);

  Future<String> sendMessage(String message, {int maxTokens = 200}) async {
    final body = {
      "model": "mistral-small",
      "messages": [
        {"role": "user", "content": message}
      ],
      "temperature": 0.7,
      "max_tokens": maxTokens,
    };

    // final data = await _apiClient.post(ApiRoutes.apiKey, body);
    final data = await _apiClient.post(
      "/chat/completions",
      body,
    );

    return data['choices'][0]['message']['content'];
  }

}*/
import '../../core/network/api_client.dart';

class MistralRemoteDataSource {
  final ApiClient _apiClient;

  MistralRemoteDataSource(this._apiClient);

  Future<String> sendMessage(String message, {int maxTokens = 200}) async {
    final body = {
      "model": "mistral-small-latest",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful email assistant. Always reply in the user’s requested language."
        },
        {
          "role": "user",
          "content": message,
        }
      ],
      "temperature": 0.7,
      "max_tokens": maxTokens,
    };

    final data = await _apiClient.post(
      "/chat/completions", // ✅ correct endpoint
      body,
    );

    return data['choices'][0]['message']['content'];
  }
}
