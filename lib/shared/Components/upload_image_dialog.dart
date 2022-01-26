import 'package:flutter/material.dart';

class UploadImagDialog extends StatelessWidget {
  UploadImagDialog({Key? key, required this.onTap}) : super(key: key);
  GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: InkWell(
        child: Text("Upload Image"),
        onTap: onTap,
      ),
    );
  }
}
