import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/common/silder.dart';
import '../../core/common/tones.dart';
import '../result_write_mail/controller/controller.dart';
import '../write_mail/control/controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<WriteMailController>(() => WriteMailController(), fenix: true);
    Get.lazyPut<MailLengthController>(() => MailLengthController(), fenix: true);
    Get.lazyPut<ToneController>(() => ToneController(), fenix: true);
    Get.lazyPut<MistralController>(() => MistralController(), fenix: true);
  }
}
