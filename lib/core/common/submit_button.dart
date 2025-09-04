import 'dart:math' as math;
import 'package:email_generator/core/common/silder.dart';
import 'package:email_generator/core/common/tones.dart';
import 'package:email_generator/pages/result_write_mail/view/result_write_mail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/result_write_mail/controller/controller.dart';
import '../../pages/write_mail/control/controller.dart';
class SubmitButtonBar extends StatelessWidget {
  final Color greetingsColor;
  final Color kWhite;
  final MistralController controller = Get.find<MistralController>();
  final toneController = Get.find<ToneController>();
  final MailLengthController lengthController = Get.find<MailLengthController>();
  final WriteMailController Writmailcontroller = Get.find<WriteMailController>();

  final TextEditingController textController;

  SubmitButtonBar({
    super.key,
    required this.greetingsColor,
    required this.kWhite,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: Obx(
                () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greetingsColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                    print("starting working");
                    if (textController.text.isNotEmpty) {
                      print("🚀 Prompt: ${textController.text}");
                      print("🌐 Language: ${Writmailcontroller.selectedLanguage.value}");
                      print("🎭 Tone: ${toneController.selectedTone.value}");
                      print("📏 Length: ${lengthController.currentLabel}");

                      final success = await controller.callMistral(
                        prompt: textController.text,
                        language: Writmailcontroller.selectedLanguage.value,
                        tone: toneController.selectedTone.value,
                        length: lengthController.currentLabel,
                      );

                      if (success) {
                        Get.to(() => ResultScreen(
                          response: controller.responseText.value,
                        ));
                      } else {
                        Get.snackbar(
                          "Error",
                          "Failed to generate response",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    }
                  },

                  child: controller.isLoading.value
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text("Submit", style: TextStyle(color: kWhite)),
                  const SizedBox(width: 8),
                  Transform.rotate(
                    angle: -math.pi / 4,
                    child: Icon(Icons.send, color: kWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



