import '../../core/network/api_client.dart';

abstract class ChatRepository {
  Future<String> sendMessage(String message, {int maxTokens});
}
class ChatRepositoryImpl implements ChatRepository {
  final ApiClient apiClient;

  ChatRepositoryImpl(this.apiClient);

  @override
  Future<String> sendMessage(String message, {int maxTokens = 200}) async {
    final data = await apiClient.post("/chat", {
      "message": message,
      "max_tokens": maxTokens,
    });
    return data["response"] ?? "";
  }
}