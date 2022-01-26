import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/modules/bottom_navigation_bar/bottom_nanigation_bar.dart';
import 'package:task/shared/Components/indecator_dialog.dart';

class FirebaseLoginAndSignUp {
  Future<void> signUpWithFirebase(String email, String password, String name,
      num phone, BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return IndecatorDialog();
      },
    );
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      Navigator.pop(context);
      String errorMessage = "Somthing went wrong";
      if (error.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        errorMessage = "this email is already used by another account.";
      } else if (error.toString() ==
          "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
        errorMessage = "The password is invalid .";
      } else if (error.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        errorMessage = "this Email is Invalid";
      } else if (error.toString() ==
          "[firebase_auth/weak-password] Password should be at least 6 characters") {
        errorMessage = 'Password must be at least 6 characters';
      }
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
      ));
    });
    if (result != null) {
      var newResult = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({
        'uid': result.user!.uid,
        'name': '$name',
        'email': '$email',
        'password': '$password',
        'phone': phone,
        'posts': 0,
        'followers': 0,
        'following': 0,
        'pic_url': '',
        'cover_url': ''
      }).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.black,
              ),
              Text(
                "Signed up succssfully",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
        ));
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
    print(result);
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return IndecatorDialog();
      },
    );
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      Navigator.pop(context);
      String errorMessage = "Somthing went wrong";
      if (error.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        errorMessage = "this email is already used by another account.";
      } else if (error.toString() ==
          "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
        errorMessage = "The password is invalid .";
      } else if (error.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        errorMessage = "this Email is Invalid";
      }
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        backgroundColor: Colors.white,
      ));
    });

    if (result != null) {
      SharedPreferences instance = await SharedPreferences.getInstance();
      instance.setString('email', email);
      instance.setString('uid', result.user!.uid).whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavgationBarPage(),
            ),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.black,
              ),
              Text(
                "Signed in succssfully",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          backgroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
        ));
      });
    }
  }
}
