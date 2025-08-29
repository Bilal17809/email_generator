import 'package:flutter/material.dart';
class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12), // space around navbar
      decoration: BoxDecoration(
        color: Colors.white, // background color
        borderRadius: BorderRadius.circular(10), // rounded corners
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
          backgroundColor: Colors.transparent, // use container bg
          elevation: 0,
          selectedItemColor: Colors.blue, // active icon color
          unselectedItemColor: Colors.grey, // inactive icon color
          type: BottomNavigationBarType.fixed,
          iconSize: 28, // 🔹 resize icons
          selectedFontSize: 14, // 🔹 resize text
          unselectedFontSize: 12,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
