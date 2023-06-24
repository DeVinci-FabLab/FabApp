import 'package:fabapp/constants/consts.dart';
import 'package:flutter/material.dart';

import 'package:fabapp/pages/auth/sign_in.dart';
import 'package:fabapp/pages/auth/sign_up.dart';
import 'package:fabapp/components/buttons.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/img/logo_fablab.png',
                width: 250,
                height: 100,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 50),
              LogButton(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                ),
                text: 'Se connecter',
                color: Constants.devinciColor,
              ),
              const SizedBox(height: 20),
              LogButton(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                ),
                text: 'S\'inscrire',
                color: Constants.devinciColorLigth,
              ),
              const SizedBox(height: 120),
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
          ),
        ),
      ),
    );
  }
}
