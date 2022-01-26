import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/bottom_navigation_bar/bottom_nanigation_bar.dart';
import 'package:task/modules/sign_up/sign_up.dart';
import 'package:task/servces/firebase_auth.dart';
import 'package:task/servces/shared_prefs.dart';
import 'package:task/shared/Components/my_button.dart';
import 'package:task/shared/Components/my_text_field.dart';
import 'package:task/shared/Components/password_feild.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseLoginAndSignUp auth = FirebaseLoginAndSignUp();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SharedPrefs prefs = SharedPrefs();
    prefs.loggedInBefore(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.1,
                ),
                Text(
                  "Meawer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                MyTextField(
                  icon: Icons.email_outlined,
                  isItEmail: true,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10,
                ),
                PasswordField(
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(
                        txt: 'Login',
                        onPressed: () {
                          print("AMr");
                          if (_formKey.currentState!.validate()) {
                            auth.login(_emailController.text,
                                _passwordController.text, context);
                          }
                        }),
                    MyButton(
                        txt: "Sign Up",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPAge(),
                              ));
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
