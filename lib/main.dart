import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meower',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            centerTitle: true,
            elevation: 0,
          )),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
