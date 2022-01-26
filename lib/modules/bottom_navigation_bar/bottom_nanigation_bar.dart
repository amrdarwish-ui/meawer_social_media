import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/post.dart';
import 'package:task/modules/home/home.dart';
import 'package:task/modules/new_post/new_post.dart';
import 'package:task/modules/notifications/notifications.dart';
import 'package:task/modules/profile/profile.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class BottomNavgationBarPage extends StatefulWidget {
  BottomNavgationBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavgationBarPageState createState() => _BottomNavgationBarPageState();
}

class _BottomNavgationBarPageState extends State<BottomNavgationBarPage> {
  int selectedItem = 0;
  List<Widget> bodiesList = <Widget>[
    Home(
      showOnlyCurrentUSerPosts: false,
    ),
    Notifications(),
    Profile(
      isCurrentUserProfile: true,
      vistUserID: '',
    ),
  ];
  //List<String> appBartitle = <String>['News Feed', 'Notifications', 'Profile'];
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logocyan.png',
          height: size.height * 0.06,
          width: size.height * 0.06,
        ),
      ),
      body: bodiesList[selectedItem],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPost(),
              ));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.smoothEdge,
          backgroundColor: Colors.cyan[100],
          leftCornerRadius: 50,
          splashRadius: 50,
          splashColor: Colors.cyan,
          activeColor: Colors.cyan,
          inactiveColor: Colors.cyan,
          elevation: 10,
          icons: [
            selectedItem == 0 ? Icons.home : Icons.home_outlined,
            selectedItem == 1
                ? Icons.notifications
                : Icons.notifications_outlined,
            selectedItem == 2 ? Icons.person : Icons.person_outline,
          ],
          activeIndex: selectedItem,
          onTap: (value) {
            setState(() {
              selectedItem = value;
            });
          }),
    );
  }
}
