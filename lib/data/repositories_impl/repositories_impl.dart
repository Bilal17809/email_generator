import '/domain/repositories/chat_repository.dart';
import '../remote_data_source/data_sources.dart';


class ChatRepositoryImpl implements ChatRepository {
  final MistralRemoteDataSource api;

  ChatRepositoryImpl(this.api);

  @override
  Future<String> sendMessage(String message, {int maxTokens = 200}) {
    return api.sendMessage(message, maxTokens: maxTokens);
  }
}