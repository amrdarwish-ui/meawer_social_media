import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/models/post.dart';
import 'package:task/shared/Components/ask_alert_dialog.dart';
import 'package:task/shared/Components/indecator_dialog.dart';
import 'package:task/shared/Components/my_button.dart';
import 'package:task/shared/Components/my_text_field.dart';
import 'package:task/shared/show_snak_bar.dart';

class NewPost extends StatefulWidget {
  NewPost({Key? key}) : super(key: key);

  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController _postController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String url = '';
  final Random random = Random();
  int? imageName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('new meaw'),
        leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AskAlertDialog(yesFunction: () async {
                    if (url == '') {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return IndecatorDialog();
                        },
                      );
                      await FirebaseStorage.instance
                          .ref()
                          .child('PostImage/${imageName.toString()}')
                          .delete()
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    }
                  });
                },
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                showSnakBar(context, 'now internet Connection', Icons.close);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyButtonCyan(
                      txt: 'Meaw',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool isNotError = true;
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => IndecatorDialog(),
                          );
                          Post post = Post(
                              name: data['name'],
                              time: "${DateTime.now()}",
                              userUrl: data['pic_url'],
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              body: '''${_postController.text}''',
                              imageUrl: url,
                              imageName: imageName == null
                                  ? ''
                                  : imageName.toString());
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc()
                              .set(post.toMap())
                              .catchError((e) {
                            isNotError = false;
                            showSnakBar(
                                context, 'no Internet Connection', Icons.close);
                            Navigator.pop(context);
                          }).whenComplete(() {
                            if (isNotError) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showSnakBar(
                                  context, 'Your Meaw Posted', Icons.check);
                            }
                          });
                        }
                      }),
                );
              }
              return Text("loading");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadPostImage();
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostField(postController: _postController),
              url == ''
                  ? Container()
                  : Container(
                      height: size.height * 0.3, child: Image.network(url))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadPostImage() async {
    imageName = random.nextInt(11111111);
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();

    XFile image;

    //check
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //select image
      image = (await picker.pickImage(source: ImageSource.gallery))!;
      File file = File(image.path);

      if (image != null) {
        //uplod
        var uploadTask = await storage
            .ref()
            .child('PostImage/${imageName.toString()}')
            .putFile(file);
        String url = await (await uploadTask).ref.getDownloadURL();
        this.url = url;
      } else {
        print("No Image");
      }
    } else {
      print("permission error..............");
    }
  }
}
