import 'package:flutter/material.dart';
import 'package:task/servces/firebase_auth.dart';
import 'package:task/shared/Components/my_button.dart';
import 'package:task/shared/Components/my_text_field.dart';
import 'package:task/shared/Components/password_feild.dart';

class SignUpPAge extends StatelessWidget {
  SignUpPAge({Key? key}) : super(key: key);
  FirebaseLoginAndSignUp auth = FirebaseLoginAndSignUp();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.cyan[300],
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.1,
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
                    height: size.height * 0.07,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "SIGN UP",
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
                      label: 'Name',
                      isItEmail: false,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _nameController),
                  SizedBox(
                    height: 10,
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
                  MyTextField(
                    icon: Icons.phone_outlined,
                    isItEmail: false,
                    label: 'Phone',
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
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
                          txt: "Sign Up",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              auth.signUpWithFirebase(
                                  _emailController.text,
                                  _passwordController.text,
                                  _nameController.text,
                                  num.parse(_phoneController.text),
                                  context);
                            }
                            print(_emailController.text);
                          }),
                      MyButton(
                          txt: 'Login',
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  )
                ])),
          ),
        ));
  }
}
