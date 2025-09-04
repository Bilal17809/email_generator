import 'package:email_generator/core/constant/constant.dart';
import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/select_language.dart';
import '../../../core/common/length.dart';
import '../../../core/common/submit_button.dart';
import '../../../core/common/tones.dart';
import '../control/controller.dart';

class WriteMail extends StatelessWidget {
  WriteMail({super.key});
  final TextEditingController textController = TextEditingController();
  final WriteMailController controller = Get.put(WriteMailController());

  /// ✅ Open draggable bottom sheet with languages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kWhiteEF,
      appBar: Appbar(),
      body: Stack(
        children: [
          // 🟦 Background (Column with Image)
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
              children: [Gridview(), Body(textController: textController), SizedBox(height: 50)],
            ),
          ),

          // 🟥 Button fixed at bottom (always on top)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.1,
            child:SubmitButtonBar(
              greetingsColor: greetingsColor,
              kWhite: kWhite,
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
            height: context.screenHeight * 0.07,
            color: greetingsColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 13),
              child: Text(
                "Write Mail",
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 6),
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
                      child: TextField(
                        controller:textController,
                        decoration: const InputDecoration(
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

                  const Spacer(),

                  // 🎤 Mic at bottom
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: greetingsColor,
                        child: Icon(Icons.mic, color: kWhite),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back_rounded, color: greetingsColor, size: 30),
      ),
      title: Text("Write Mail", style: TextStyle(color: greetingsColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
