import 'package:email_generator/pages/home/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  // DependencyInject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
