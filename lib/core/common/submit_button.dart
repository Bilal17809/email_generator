import 'dart:math' as math;
import 'package:email_generator/pages/result_write_mail/view/result_write_mail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/result_write_mail/controller/controller.dart';


class SubmitButtonBar extends StatelessWidget {
  final Color greetingsColor;
  final Color kWhite;
  final MistralController controller = Get.put(MistralController());
  final TextEditingController textController = TextEditingController();

   SubmitButtonBar({
    super.key,
    required this.greetingsColor,
    required this.kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(

      color: Colors.transparent, // background of nav bar
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: greetingsColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // rounded button
              ),
            ),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  controller.callMistral(
                    prompt: textController.text,
                    language:controller.selectedLanguage.value,
                    tone: controller.selectedTone.value,

                    length: controller.selectedLength.value,
                  );
                }
                Get.to(() => ResultScreen());
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // keep centered
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
    );
  }
}
