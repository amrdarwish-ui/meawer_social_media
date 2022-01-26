import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/bottom_navigation_bar/bottom_nanigation_bar.dart';

class SharedPrefs {
  void loggedInBefore(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString('email');
    if (email != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return BottomNavgationBarPage();
        },
      ));
    }
  }

  void clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
