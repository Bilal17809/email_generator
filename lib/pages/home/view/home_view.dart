import 'package:email_generator/core/constant/constant.dart';
import 'package:email_generator/pages/tools/view/tools.dart';
import 'package:email_generator/pages/write_mail/view/write_mail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../../replay_mail/view/replay_mail.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      extendBody: true,            // 🔹 lets body go behind BottomNavigationBar
      extendBodyBehindAppBar: true, // 🔹 lets body go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // so image shows behind
        elevation: 0,
        leading: Icon(Icons.menu, size: 30, color: greetingsColor),
        title: Text("AI Email writer", style: TextStyle(color: greetingsColor)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3C9CF6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                minimumSize: const Size(0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Get Pro",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Image.asset("images/premium.png", height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          /// 🔹 Background images
          Column(
            children: [
              SizedBox(
                height: context.screenHeight * 0.25, // top portion
                width: double.infinity,
                child: Image.asset(
                  "images/769.png",
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: context.screenHeight * 0.35, // bottom portion
                width: double.infinity,
                child: Image.asset(
                  "images/769.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          /// 🔹 Scrollable content on top
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                SizedBox(
                  width: context.screenWidth * 0.86,
                  height: context.screenHeight * 0.05,
                  child: TextField(
                    cursorHeight: 15,
                    cursorColor: greetingsColor,
                    decoration: InputDecoration(
                      hint: Text("Enter your name"),
                      prefixIcon: Icon(Icons.search, color: greetingsColor),
                      filled: true,
                      fillColor: kWhite,
                      // 🔹 Custom border radius
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: greetingsColor, width: 0.5),
                        // set your radius here
                      ),
                      // 🔹 Optional: when focused
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: greetingsColor, width: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: (){
                    Get.to(()=>WriteMail());

                  },
                  child: Container(
                    width: context.screenWidth * 0.856,
                    height: context.screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: box1Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Container(
                          height: context.screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: icon1Color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "images/2.0x/pen.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Write Mail",
                          style: TextStyle(fontSize: 20, color: kWhite),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:(){
                        Get.to(()=>ReplayMail());
                      },
                      child: Container(
                        width: context.screenWidth * 0.4,
                        height: context.screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: box2Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: context.screenHeight * 0.06,
                                decoration: BoxDecoration(
                                  color: icon2Color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  "images/replay.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),

                            Text(
                              "Replay Mail",
                              style: TextStyle(fontSize: 15, color: kWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(()=>Tools());
                      },
                      child: Container(
                        width: context.screenWidth * 0.4,
                        height: context.screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: box3Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: context.screenHeight * 0.065,
                              width: context.screenWidth * 0.13,
                              decoration: BoxDecoration(
                                color: icon3Color,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                "images/repair.png",
                                width: 10,
                                height: 10,
                              ),
                            ),
                            Text(
                              "Tools",
                              style: TextStyle(fontSize: 15, color: kWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "History",
                      style: TextStyle(color: greetingsColor, fontSize: 20),
                    ),
                  ),
                ),
                Lottie.asset(
                  'images/bO2iE4P8Xn.json', // put file in assets
                  width: 200,
                  height: 200,
                  repeat: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Write Emails on the Go with\n"
                        "\t\t\t\t\t\t\t\t\t\tthe power of AI ",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );

  }
}
