import 'package:flutter/material.dart';
import 'package:task/shared/Components/indicator.dart';

class IndecatorDialog extends StatelessWidget {
  const IndecatorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MyIndicatior(),
    );
  }
}
