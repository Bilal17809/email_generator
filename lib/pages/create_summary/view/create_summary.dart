import 'package:email_generator/core/constant/constant.dart';
import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/select_language.dart';
import '../../../core/common/slider.dart';
import '../../../core/common/tones.dart';
import '../../write_mail/control/controller.dart';


class CreateSummary extends StatelessWidget {
  CreateSummary({super.key});

  final WriteMailController controller = Get.put(WriteMailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteEF,
      extendBody: true,

      extendBodyBehindAppBar: true,
      // 🔹
      appBar:CustomAppBar() ,
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              SizedBox(
                height: context.screenHeight * 0.25, // bottom portion
                width: double.infinity,
                child: Image.asset("images/769.png", fit: BoxFit.cover),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              CustomGrid(),
              SizedBox(height: 20),
              Body(),
              SizedBox(height: 5),

            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.1,
            child:  Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greetingsColor,
                  maximumSize: const Size(250, 60),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next", style: TextStyle(color: kWhite)),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: greetingsColor,
          size: 30,
        ),
      ),
      title: Text("Create Summary", style: TextStyle(color: greetingsColor)),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LanguageSelector(),

          ToneSelector(),
          LengthCard(),
        ],
      ),
    );
  }
}
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MailLengthSlider(),
        ),
        Container(
          width: context.screenWidth,
          height: context.screenHeight * 0.07,
          color: greetingsColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 13),
            child: Text(
              "Enter text here",
              style: TextStyle(color: kWhite, fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 5),
        Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: greetingsColor, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Paste",
                      style: TextStyle(color: greetingsColor),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: context.screenWidth * 0.85,
              height: context.screenHeight * 0.37,
              child: Card(
                color: kWhite,
                child: Column(
                  children: [
                    // 🔲 Container gives background + border
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent, // ✅ background color
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // ✅ rounded corners
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            border: InputBorder.none, // 🚫 no TextField border
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),



                    // 🎤 Mic at bottom

                  ],
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}



