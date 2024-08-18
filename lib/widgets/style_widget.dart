import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle TextFieldStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle HeaderFieldStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontFamily: 'Poppins');
  }

  static TextStyle LightFieldStyle() {
    return const TextStyle(
        color: Colors.black54,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }
  static TextStyle semiboldFieldStyle(){
    return const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');

  }
}
