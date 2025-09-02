import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailLengthController extends GetxController {
  RxDouble value = 1.0.obs; // 0 = Short, 1 = Medium, 2 = Long
  final List<String> labels = ["Short", "Medium", "Long"];
}

class MailLengthSlider extends StatelessWidget {
  const MailLengthSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final MailLengthController controller = Get.put(MailLengthController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
            label: controller.labels[controller.value.value.toInt()],
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
      ),
    );
  }
}
