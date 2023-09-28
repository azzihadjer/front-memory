// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';
import 'package:memory_main/pages/login_page.dart';
import 'package:memory_main/visitor/home_page.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({Key? key});

  @override
  _ButtonNavBarState createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 40,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFBFFFC7),
            Color(0xFFf9e866),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: const Color(0xFF7DBD72),
          activeColor: const Color(0xFF7DBD72),
          tabBackgroundColor: const Color(0xFFDEDFDA),
          padding: const EdgeInsets.all(6.5),
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                // Navigate to the Home page
                Get.offAll(() => const HomePage());
                break;
              case 1:
                // Navigate to the Account page
                Get.offAll(() => const LoginPage());
                break;
              default:
                // Navigate to the More page

                break;
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.person,
              text: "Compte",
            ),
            GButton(
              icon: Icons.more_horiz_outlined,
              text: "More",
            ),
          ],
        ),
      ),
    );
  }
}
