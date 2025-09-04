
import '../repositories/chat_repository.dart';

class SendMessageUseCase {

  final ChatRepository repository;
  SendMessageUseCase(this.repository);
  Future<String> call(String message, {int maxTokens = 200}) {
    return repository.sendMessage(message, maxTokens: maxTokens);
  }
}
