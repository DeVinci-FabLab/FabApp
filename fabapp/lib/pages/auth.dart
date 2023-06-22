import 'package:flutter/material.dart';

import 'package:fabapp/components/custom_textfield.dart';
import 'package:fabapp/components/custom_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void onSignIn(BuildContext context) {
    if (usernameController.text == 'admin' &&
        passwordController.text == 'secret') {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const HomePage(),
      //   ),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez réessayer. Nom d\'utilisateur ou mot de passe incorrect.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset(
                'assets/img/logo_fablab.png',
                width: 250,
                height: 100,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: usernameController,
                labelText: 'Identifiant',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                labelText: 'Mot de passe',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'id : admin\npassword : secret',
                        ),
                      ),
                    ),
                    child: const Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(
                        color: Color(0xFF0958EF),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () => onSignIn(context),
                text: 'Se connecter',
              ),
              const SizedBox(height: 60),
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
