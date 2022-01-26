import 'package:flutter/material.dart';
import 'package:task/shared/Components/my_button.dart';

class AskAlertDialog extends StatelessWidget {
  AskAlertDialog({Key? key, required this.yesFunction}) : super(key: key);

  GestureTapCallback yesFunction;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      actions: [
        MyButtonCyanLight(
            txt: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            }),
        MyButtonCyanLight(txt: 'Yes', onPressed: yesFunction)
      ],
    );
  }
}
