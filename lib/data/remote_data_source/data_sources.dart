import '../../../core/config/api_routes.dart';
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

    final data = await _apiClient.post(ApiRoutes.apiKey, body);
    return data['choices'][0]['message']['content'];
  }

}
