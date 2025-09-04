import 'package:email_generator/core/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/submit_button.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/controller.dart';

class ResultScreen extends StatelessWidget {
  final String response;

   ResultScreen({super.key, required this.response});
  final MistralController controller = Get.put(MistralController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white.withOpacity(0.99),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_rounded)),
        title: Text("Result"),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(CupertinoIcons.delete_simple, color: greetingsColor),
        )],
      ),
      body: Stack(
        children: [
          // 🟦 Background (Column with Image)


          // 🟨 Scrollable Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                   SizedBox(height: 70,),
              SizedBox(
                width: context.screenWidth * 0.9,
                height: context.screenHeight * 0.53,
                child: Card(
                  color: kWhite,
                  child: Column(
                    children: [
                      // 🔲 Container gives background + border
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0, right: 7),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.transparent,
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     child: TextField(
                      //       controller: textController,
                      //       decoration: InputDecoration(
                      //         hintText: "Type your message...",
                      //         border: InputBorder.none,
                      //         suffixIcon: IconButton(
                      //           icon:  Icon(Icons.search,color: greetingsColor,),
                      //           onPressed: () {
                      //             // if (textController.text.isNotEmpty) {
                      //             //   controller.callMistral(textController.text);
                      //             // }
                      //           },
                      //         ),
                      //         contentPadding: EdgeInsets.symmetric(
                      //           vertical: 12,
                      //           horizontal: 16,
                      //         ),
                      //       ),
                      //
                      //       maxLines: 3,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),

                      // Show response with GetX
                      Flexible(
                        flex: 4,
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            // ⏳ Loading state
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (controller.responseText.value.isEmpty ||
                              controller.responseText.value == "Type something and press Ask Mistral...") {
                            // ℹ️ No response yet
                            return const Center(
                              child: Text(
                                "No response yet.\nType your email and press Submit.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            );
                          }

                          // ✅ AI response
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                controller.responseText.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const Spacer(),

                      // 🎤 Mic at bottom
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildSmallButton(Icons.rotate_left_rounded, "Rewrite"),
                              _buildSmallButton(Icons.expand, "Expand"),
                              _buildSmallButton(Icons.short_text, "Short"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              SizedBox(
                height: context.screenHeight * 0.19,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // SubmitButtonBar wrapped in Expanded to avoid RenderBox error
                      Expanded(
                        child: SizedBox(
                          height: context.screenHeight * 0.12,
                          child:SubmitButtonBar(
                            greetingsColor: Colors.blue,
                            kWhite: Colors.white,
                            textController: textController, // 🔥 shared
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent, // no background for CircleAvatar
                          child: Icon(Icons.copy, color: greetingsColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // 🟥 Bottom buttons fixed with proper constraints


    );

  }}

  Widget _buildSmallButton(IconData icon, String text) {
    return Container(
      width: 76,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: greetingsColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: greetingsColor),
            const SizedBox(width: 4),
            Text(text, style: TextStyle(color: greetingsColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }