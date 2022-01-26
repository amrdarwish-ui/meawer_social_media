import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle titlesStyle(BuildContext context) {
  return TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.bold);
}
