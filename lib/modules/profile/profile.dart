import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/shared/Components/indicator.dart';
import 'package:task/shared/Components/profile_body.dart';

class Profile extends StatelessWidget {
  Profile(
      {Key? key, required this.isCurrentUserProfile, required this.vistUserID})
      : super(key: key);
  bool isCurrentUserProfile;
  String vistUserID;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: isCurrentUserProfile
          ? null
          : AppBar(
              title: Image.asset(
                'assets/images/logocyan.png',
                height: size.height * 0.06,
                width: size.height * 0.06,
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(vistUserID == ''
                ? FirebaseAuth.instance.currentUser!.uid
                : vistUserID)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Center(child: Text("Document does not exist"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MyIndicatior();
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data['cover_url']);
          return ProfileBody(
            isCurrentUserProfile: isCurrentUserProfile,
            size: size,
            userId: data['uid'],
            coverUrl: data['cover_url'],
            email: data['email'],
            imageUrl: data['pic_url'],
            name: data['name'],
            phone: data['phone'].toString(),
            folllowers: data['followers'],
            following: data['following'],
            posts: data['posts'],
          );
        },
      ),
    );
  }
}
