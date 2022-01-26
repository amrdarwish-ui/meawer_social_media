import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  PasswordField({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter password';
          }
          return null;
        },
        cursorColor: Colors.white,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key_outlined,
            color: Colors.white,
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: 'Password',
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
