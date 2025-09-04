abstract class ChatRepository {
  Future<String> sendMessage(String message, {int maxTokens});
}
