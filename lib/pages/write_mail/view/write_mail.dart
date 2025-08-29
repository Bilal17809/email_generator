import 'package:email_generator/core/constant/constant.dart';
import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WriteMail extends StatelessWidget {
  const WriteMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_rounded,
          color: greetingsColor,
          size: 30,
        ),
        title: Text("Write Mail", style: TextStyle(color: greetingsColor)),
      ),
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
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: kToolbarHeight - 50,
              bottom: kBottomNavigationBarHeight + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Grid inside scroll view
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Card(
                        color: Colors.pink.shade50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 1),
                                Icon(Icons.flag_outlined, size: 18),
                                SizedBox(width: 1),
                                Text(
                                  "\t English\n"
                                  "(Canada)",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Icon(
                                  Icons.play_circle,
                                  color: Colors.pinkAccent,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.purple.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tone",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  "Friendly",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(width: 3),
                                Icon(
                                  Icons.play_circle,
                                  color: Colors.orange.shade600,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.blue.shade50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Length",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text("Medium", style: TextStyle(fontSize: 14)),
                                SizedBox(width: 3),

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
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.07,
                  color: greetingsColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 13),
                    child: Text(
                      "Email Instructions",
                      style: TextStyle(color: kWhite, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: SizedBox(
                    width: context.screenWidth * 0.73,
                    height: context.screenHeight * 0.5,
                    child: Card(
                      color: greetingsColorWithAlpha,
                      child: Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: CircleAvatar(
                            backgroundColor: greetingsColor,
                            child: Icon(Icons.mic, color: kWhite, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greetingsColor,
                      maximumSize: const Size(250, 60),
                    ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Submit"
                          ,style: TextStyle(
                              color: kWhite,

                            ),),
                          SizedBox(width: 5,),
                          Icon(Icons.send_rounded,color: kWhite,)
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
