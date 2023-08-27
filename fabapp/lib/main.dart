import 'package:fabapp/pages/auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FabApp());
}

class FabApp extends StatelessWidget {
  const FabApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FabLab App',
      //debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
