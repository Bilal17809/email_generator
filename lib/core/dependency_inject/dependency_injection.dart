import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../common/silder.dart';
import '../common/tones.dart';
import '../../pages/result_write_mail/controller/controller.dart';
import '../../pages/write_mail/control/controller.dart';
import '../network/api_client.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<WriteMailController>(() => WriteMailController(), fenix: true);
    Get.lazyPut<MailLengthController>(() => MailLengthController(), fenix: true);
    Get.lazyPut<ToneController>(() => ToneController(), fenix: true);
    Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(Get.find<ApiClient>()), fenix: true);
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
