import 'package:flutter/material.dart';

class MyIndicatior extends StatelessWidget {
  const MyIndicatior({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.cyan,
        backgroundColor: Colors.white,
      ),
    );
  }
}
