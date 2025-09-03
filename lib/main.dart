import 'package:email_generator/core/theme/app_colors.dart';
import 'package:email_generator/pages/home/widget/widget.dart';
import 'package:email_generator/pages/write_mail/control/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/common/silder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WriteMailController());
  Get.put(MailLengthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: greetingsColor, // cursor color
          selectionColor: greetingsColorWithAlpha, // text highlight color
          selectionHandleColor: greetingsColor, // drag handles color
        ),
      ),
      home: const MyBottomNavBar(),
    );
  }
}

/*
api
Nt2RltbSyInTvsF5su1hNPG5b8xnvt9L*/
