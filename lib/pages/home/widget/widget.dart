import 'package:email_generator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../email_template/view/email_template.dart';
import '../../setting/view/setting.dart';
import '../view/home_view.dart';
class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeView(),
    EmailTemplate(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,            // 🔹 lets body go behind BottomNavigationBar
      extendBodyBehindAppBar: true, // 🔹
      body: _screens[_currentIndex], // change page here
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: greetingsColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            iconSize: 28,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Templates",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example pages