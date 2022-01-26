import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/home/home.dart';
import 'package:task/shared/Components/custom_post.dart';
import 'package:task/shared/Components/indicator.dart';

class CurrentUserPosts extends StatelessWidget {
  CurrentUserPosts({Key? key, required this.vistUserid}) : super(key: key);
  String vistUserid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('your Meaws'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: vistUserid != FirebaseAuth.instance.currentUser!.uid
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where(
                    'userId',
                    isEqualTo: vistUserid,
                  )
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MyIndicatior();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return CustomPost(
                          isInfollowerVeiw: true,
                          showOnlyCurrentUSerPosts: false,
                          userId: data['userId'],
                          body: data['body'],
                          postId: document.id,
                          imageName:
                              data['imageName'] == '' ? '' : data['imageName'],
                          comments: data['comments'],
                          imageUrl: data['imageUrl'],
                          likes: data['likes'],
                          name: data['name'],
                          time: data['time'],
                          userUrl: data['userUrl']);
                    }).toList(),
                  ),
                );
              },
            )
          : Home(showOnlyCurrentUSerPosts: true),
    );
  }
}
