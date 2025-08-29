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
        leading: Icon(Icons.arrow_back_rounded,color: greetingsColor,size: 30,),
        title: Text("Write Mail",style: TextStyle(
          color: greetingsColor
        ),),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              SizedBox(
                height: context.screenHeight * 0.25, // bottom portion
                width: double.infinity,
                child: Image.asset(
                  "images/769.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 3, // 2 items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
               Card(
               color: Colors.pink.shade50,

               ),
                Card(
color: Colors.purple.shade100,

                ),
                Card(
                  color: Colors.blue.shade50,


                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
