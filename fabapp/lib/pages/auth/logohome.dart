import 'package:flutter/material.dart';

class LogoHome extends StatelessWidget {
  const LogoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/img/logo_fablab.png',
          width: 250,
          height: 100,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
