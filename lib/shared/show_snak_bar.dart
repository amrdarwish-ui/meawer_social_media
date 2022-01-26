import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, String txt, IconData icon) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(
          "$txt",
          style: TextStyle(color: Colors.black),
        )
      ],
    ),
    backgroundColor: Colors.cyan[50],
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
  ));
}
