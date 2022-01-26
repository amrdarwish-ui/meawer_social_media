import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key, required this.txt, required this.onPressed})
      : super(key: key);

  String txt;
  GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            "$txt",
            style: TextStyle(color: Colors.cyan[300], fontSize: 18),
          )),
    );
  }
}

class MyButtonCyanLight extends StatelessWidget {
  MyButtonCyanLight({Key? key, required this.txt, required this.onPressed})
      : super(key: key);

  String txt;
  GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.teal[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            "$txt",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.03,
            ),
          )),
    );
  }
}

class MyButtonCyan extends StatelessWidget {
  MyButtonCyan({Key? key, required this.txt, required this.onPressed})
      : super(key: key);

  String txt;
  GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            "$txt",
            style: TextStyle(color: Colors.black, fontSize: 12),
          )),
    );
  }
}

class MyButtonViewPosts extends StatelessWidget {
  MyButtonViewPosts({Key? key, required this.txt, required this.onPressed})
      : super(key: key);

  String txt;
  GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            "$txt",
            style: TextStyle(color: Colors.black, fontSize: 12),
          )),
    );
  }
}
