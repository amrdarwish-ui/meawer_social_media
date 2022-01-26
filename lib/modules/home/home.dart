import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/shared/Components/custom_post.dart';
import 'package:task/shared/Components/indicator.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.showOnlyCurrentUSerPosts}) : super(key: key);
  bool showOnlyCurrentUSerPosts;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: showOnlyCurrentUSerPosts
              ? FirebaseFirestore.instance
                  .collection('posts')
                  .where(
                    'userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .orderBy('time', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('time', descending: true)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyIndicatior();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return CustomPost(
                      isInfollowerVeiw: false,
                      showOnlyCurrentUSerPosts: showOnlyCurrentUSerPosts,
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
        ));
  }
}
