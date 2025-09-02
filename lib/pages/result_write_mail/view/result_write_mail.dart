import 'package:email_generator/core/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/common/submit_button.dart';
import '../../../core/theme/app_colors.dart';

class ResultScreen extends StatelessWidget {
  final Color greetingsColo = greetingsColor; // replace with your color
  final Color greetingsColorWithAlpha = Colors.blue.withOpacity(0.2);
  final Color kWhite = Colors.white;

 ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_rounded),
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
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // leave space for bottomNavigationBar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SizedBox(
                    width: context.screenWidth * 0.8,
                    height: context.screenHeight * 0.7,
                    child: Card(
                      color: kWhite,
                      child: Column(
                        children: [
                          // 🔲 Container gives background + border
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 7),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Type your message...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                ),
                                maxLines: 3,
                              ),
                            ),
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
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),

      // 🟥 Bottom buttons fixed with proper constraints
        bottomNavigationBar: SizedBox(
          height: context.screenHeight * 0.19,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // SubmitButtonBar wrapped in Expanded to avoid RenderBox error
                Expanded(
                  child: SizedBox(
                    height: context.screenHeight * 0.12,
                    child: SubmitButtonBar(
                      greetingsColor: greetingsColor,
                      kWhite: kWhite,
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