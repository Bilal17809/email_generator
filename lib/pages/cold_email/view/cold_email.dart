import 'package:email_generator/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/select_language.dart';
import '../../../core/common/slider.dart';
import '../../../core/common/submit_button.dart';
import '../../../core/common/tones.dart';
import '../../../core/theme/app_colors.dart';
import '../../write_mail/control/controller.dart';

class ColdEmail extends StatelessWidget {
  ColdEmail({super.key});
  final TextEditingController textController = TextEditingController();
  final WriteMailController controller = Get.find<WriteMailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kWhiteEF,
      appBar: Appbar(),
      body: Stack(
        children: [

          Column(
            children: [
              const Spacer(),
              SizedBox(
                height: context.screenHeight * 0.25,
                width: double.infinity,
                child: Image.asset("images/769.png", fit: BoxFit.cover),
              ),
            ],
          ),

          // 🟨 Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Gridview(), Body(textController: textController),],
            ),
          ),

          // 🟥 Button fixed at bottom (always on top)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.1,
            child:SubmitButtonBar(
              text: "Submit",
              greetingsColor: Colors.blue,
              kWhite: Colors.white,
              textController: textController, // 🔥 shared
            ),
          ),
        ],
      ),
    );
  }
}

class Gridview extends StatelessWidget {
  const Gridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // ✅ Language Card
          LanguageSelector(),
          // ✅ Tone Card (static for now)
          ToneSelector(),
          LengthCard(),

        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.textController});

  final TextEditingController textController ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MailLengthSlider(),
          ),
          // MailLengthSlider(),
          Container(
            width: context.screenWidth,
            height: context.screenHeight * 0.04,
            color: greetingsColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Text(
                "Tell us about your product",
                style: TextStyle(color: kWhite, fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 6),
          SizedBox(
            width: context.screenWidth * 0.95,
            height: context.screenHeight * 0.15,
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
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller:textController,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none, // 🚫 no TextField border
                          contentPadding: EdgeInsets.symmetric(

                            horizontal: 16,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          Container(
            width: context.screenWidth,
            height: context.screenHeight * 0.04,
            color: greetingsColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Text(
                "Product Name",
                style: TextStyle(color: kWhite, fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 6),
          SizedBox(
            width: context.screenWidth * 0.95,
            height: context.screenHeight * 0.15,
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
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller:textController,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none, // 🚫 no TextField border
                          contentPadding: EdgeInsets.symmetric(

                            horizontal: 16,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          Container(
            width: context.screenWidth,
            height: context.screenHeight * 0.04,
            color: greetingsColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Text(
                "Context to include in the email",
                style: TextStyle(color: kWhite, fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 6),
          SizedBox(
            width: context.screenWidth * 0.95,
            height: context.screenHeight * 0.2,
            child: Card(
              color: kWhite,
              child: Column(
                children: [
                  // 🔲 Container gives background + border
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, right: 7),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // ✅ background color
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // ✅ rounded corners
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller:textController,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none, // 🚫 no TextField border
                          contentPadding: EdgeInsets.symmetric(

                            horizontal: 16,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),

                                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteEF,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back_rounded, color: greetingsColor, size: 30),
      ),
      title: Text("Cold Mail", style: TextStyle(color: greetingsColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
