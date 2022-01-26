import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:task/shared/Components/ask_alert_dialog.dart';
import 'package:task/shared/Components/indecator_dialog.dart';
import 'package:task/shared/Components/indicator.dart';
import 'package:task/shared/Components/my_button.dart';
import 'package:task/shared/Components/my_text_field.dart';
import 'package:task/shared/show_snak_bar.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.name, required this.phone})
      : super(key: key);
  int phone;
  String name;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController.text = widget.name;
    _phoneController.text = widget.phone.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[200],
        title: Text("Edit Profile"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButtonCyanLight(
                      txt: "remove photo",
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AskAlertDialog(yesFunction: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return IndecatorDialog();
                                },
                              );

                              bool isNotError = true;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'pic_url': ''}).whenComplete(
                                      () async {
                                await FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        'userImage/${FirebaseAuth.instance.currentUser!.uid}')
                                    .delete()
                                    .catchError((erorr) {
                                  isNotError = false;
                                  showSnakBar(context, '  no photo exsits.',
                                      Icons.warning_amber);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }).whenComplete(() {
                                  if (isNotError) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showSnakBar(
                                        context, 'Photo deleted.', Icons.check);
                                  }
                                });
                              });
                            });
                          },
                        );
                      },
                    ),
                    MyButtonCyanLight(
                      txt: "remove cover",
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AskAlertDialog(yesFunction: () async {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return IndecatorDialog();
                                },
                              );
                              bool isNotError = true;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'cover_url': ''}).whenComplete(
                                      () async {
                                await FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        'coverImage/${FirebaseAuth.instance.currentUser!.uid}')
                                    .delete()
                                    .catchError((erorr) {
                                  isNotError = false;
                                  showSnakBar(context, '  no cover exsits.',
                                      Icons.warning_amber);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }).whenComplete(() {
                                  if (isNotError) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showSnakBar(
                                        context, 'Photo deleted.', Icons.check);
                                  }
                                });
                              });
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                height: size.height * 0.03,
                endIndent: size.width * 0.1,
                indent: size.width * 0.1,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Column(
                children: [
                  MyTextField(
                      label: 'Name',
                      isItEmail: false,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _nameController),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      label: 'Phone',
                      isItEmail: false,
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.number,
                      controller: _phoneController),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                      txt: 'cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MyButton(
                      txt: 'OK',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AskAlertDialog(
                              yesFunction: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return IndecatorDialog();
                                  },
                                );
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'name': _nameController.text,
                                  'phone': int.parse(_phoneController.text)
                                }).whenComplete(() {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                        );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
