import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/shared/Components/indecator_dialog.dart';

class DeletePostBottomSheet extends StatelessWidget {
  const DeletePostBottomSheet({
    Key? key,
    required this.postId,
    required this.imageName,
  }) : super(key: key);

  final String postId;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return IndecatorDialog();
                },
              );
              await FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .delete()
                  .whenComplete(() {
                Navigator.pop(context);
              });
              if (imageName != '') {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return IndecatorDialog();
                  },
                );
                await FirebaseStorage.instance
                    .ref()
                    .child('PostImage/$imageName')
                    .delete()
                    .whenComplete(() {
                  Navigator.pop(context);
                });
              }
              Navigator.pop(context);
            },
            child: ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text("Delete"),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
