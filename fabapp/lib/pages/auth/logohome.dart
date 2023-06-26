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
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
