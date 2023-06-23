import 'package:flutter/material.dart';

import 'package:fabapp/pages/auth/authpage.dart';

void main() {
  runApp(const FabApp());
}

class FabApp extends StatelessWidget {
  const FabApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FabApp',
      debugShowCheckedModeBanner: true,
      home: AuthPage(),
    );
  }
}
