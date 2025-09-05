import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailLengthController extends GetxController {
  RxDouble value = 1.0.obs; // 0 = Short, 1 = Medium, 2 = Long
  final List<String> labels = ["Short", "Medium", "Long"];

  RxBool isSliderVisible = false.obs;

  String get currentLabel => labels[value.value.toInt()];

  /// Toggle slider visibility
  void toggleSlider() {
    isSliderVisible.toggle();
  }
}

/// 🔹 Reusable Slider Widget
class MailLengthSlider extends StatelessWidget {
  const MailLengthSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final MailLengthController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mail Length",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Obx(() => Slider(
          value: controller.value.value,
          min: 0,
          max: 2,
          divisions: 2,
          label: controller.currentLabel,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.value.value = val;
          },
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.labels.map((e) => Text(e)).toList(),
          ),
        ),
      ],
    );
  }
}

/// 🔹 Card with toggle logic
class LengthCard extends StatelessWidget {
  const LengthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final MailLengthController controller = Get.put(MailLengthController());

    return Obx(() => Column(
      children: [
        // 🔹 Card (tappable)
        GestureDetector(

          child: SizedBox(
            height: 111,
            child: Card(
              color: Colors.blue.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Length",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentLabel, // ✅ dynamic text
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.play_circle,
                        color: Colors.red.shade200,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // 🔹 Show slider when tapped
        if (controller.isSliderVisible.value)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mail Length",
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: controller.value.value,
                min: 0,
                max: 2,
                divisions: 2,
                label: controller.currentLabel,
                activeColor: Colors.blue,
                onChanged: (val) {
                  controller.value.value = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  controller.labels.map((e) => Text(e)).toList(),
                ),
              ),
            ],
          ),
      ],
    ));
  }
}

