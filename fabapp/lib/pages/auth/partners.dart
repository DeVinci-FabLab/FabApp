import 'package:flutter/material.dart';

class Partners extends StatelessWidget {
  const Partners({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Nos partenaires',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo_esilv.png',
              width: 100,
              height: 80,
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/img/logo_filamentum.png',
              width: 100,
              height: 80,
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/img/logo_dvic.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ],
    );
  }
}
