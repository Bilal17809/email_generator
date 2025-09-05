import 'dart:developer';
import 'dart:math' as math;
import 'package:email_generator/core/common/slider.dart';
import 'package:email_generator/core/common/tones.dart';
import 'package:email_generator/pages/result_write_mail/view/result_write_mail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/result_write_mail/controller/controller.dart';
import '../../pages/write_mail/control/controller.dart';
class SubmitButtonBar extends StatelessWidget {
  final Color greetingsColor;
  final Color kWhite;
  final String text;
  final MistralController controller = Get.find<MistralController>();
  final toneController = Get.find<ToneController>();
  final MailLengthController lengthController = Get.find<MailLengthController>();
  final WriteMailController writeMailController = Get.find<WriteMailController>();

  final TextEditingController textController;

  SubmitButtonBar({
    super.key,
    required this.greetingsColor,
    required this.kWhite,
    required this.textController,
    required this.text,
  });

  // final _formKey = GlobalKey<FormState>();

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
                    final emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    final email = textController.text.trim();

                    // 🛑 Empty
                    if (email.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Email cannot be empty",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    // 🛑 Invalid format
                    if (!emailRegex.hasMatch(email)) {
                      Get.snackbar(
                        "Error",
                        "Enter a valid email format",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    // 🛑 Block dummy/disposable domains
                    final blockedDomains = [
                      "example.com",
                      "test.com",
                      "mailinator.com",
                      "tempmail.com",
                      "fake.com",
                    ];
                    final domain = email.split('@').last.toLowerCase();

                    if (blockedDomains.contains(domain)) {
                      Get.snackbar(
                        "Error",
                        "Please use a real email provider, not a dummy one",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    // ✅ Passed validation
                    log("🚀 Prompt: $email");
                    log("🌐 Language: ${writeMailController.selectedLanguage.value}");
                    log("🎭 Tone: ${toneController.selectedTone.value}");
                    log("📏 Length: ${lengthController.currentLabel}");

                    final success = await controller.callMistral(
                      prompt: email,
                      language: writeMailController.selectedLanguage.value,
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
                  ,
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
                  Text(text, style: context.textTheme.bodyLarge?.copyWith(color: kWhite)),
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

class EmailValidatorHelper {
  static final RegExp _emailRegex =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Block dummy/disposable domains
  static final List<String> _blockedDomains = [
    "example.com",
    "test.com",
    "mailinator.com",
    "tempmail.com",
    "fake.com",
  ];

  static String? validate(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }

    if (!_emailRegex.hasMatch(email)) {
      return "Enter a valid email format";
    }

    final domain = email.split('@').last.toLowerCase();
    if (_blockedDomains.contains(domain)) {
      return "Please use a real email provider, not a dummy one";
    }

    return null; // ✅ valid email
  }
}



