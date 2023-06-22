import 'package:flutter/material.dart';

import 'package:fabapp/pages/auth.dart';

void main() {
  runApp(const FabApp());
}

class FabApp extends StatelessWidget {
  const FabApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FabLab App',
      debugShowCheckedModeBanner: true,
      home: LoginPage(),
    );
  }
}
