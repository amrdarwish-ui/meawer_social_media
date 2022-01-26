import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {Key? key,
      required this.label,
      required this.isItEmail,
      required this.icon,
      required this.keyboardType,
      required this.controller})
      : super(key: key);

  String label;
  bool isItEmail;
  IconData icon;
  TextInputType keyboardType;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          } else if (isItEmail) {
            if (!isEmail(value)) {
              return 'Email is Invalid';
            }
          }
          return null;
        },
        controller: controller,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          labelText: "$label",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: '$label',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.white)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}

class PostField extends StatelessWidget {
  const PostField({
    Key? key,
    required TextEditingController postController,
  })  : _postController = postController,
        super(key: key);

  final TextEditingController _postController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 12,
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'You should write a caption';
          }

          return null;
        },
        controller: _postController,
        cursorColor: Colors.cyan,
        decoration: InputDecoration(
          hintText: 'Write your caption here',
          hintStyle: TextStyle(color: Colors.cyan.withOpacity(0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
