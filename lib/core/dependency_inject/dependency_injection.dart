import 'package:email_generator/core/config/config.dart';
import 'package:get/get.dart';
import '../../data/remote_data_source/data_sources.dart';
import '../../data/repositories_impl/repositories_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../common/slider.dart';
import '../common/tones.dart';
import '../../pages/result_write_mail/controller/controller.dart';
import '../../pages/write_mail/control/controller.dart';
import '../network/api_client.dart';


class DependencyInjection {
  static void init() {
    Get.lazyPut<WriteMailController>(() => WriteMailController(), fenix: true);
    Get.lazyPut<MailLengthController>(() => MailLengthController(), fenix: true);
    Get.lazyPut<ToneController>(() => ToneController(), fenix: true);
    Get.lazyPut<ApiClient>(() => ApiClient(
      baseUrl: EnvironmentConfig.baseUrl,
      apiKey: ApiRoutes.apiKey,
    ), fenix: true);
    Get.lazyPut<MistralRemoteDataSource>(
          () => MistralRemoteDataSource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(Get.find<MistralRemoteDataSource>()), fenix: true);
    Get.lazyPut<SendMessageUseCase>(
          () => SendMessageUseCase(Get.find<ChatRepository>()),
      fenix: true,
    );

    Get.lazyPut<MistralController>(
          () => MistralController(Get.find<SendMessageUseCase>()),
      fenix: true,
    );
  }
}
