import 'package:flutter/material.dart';

import 'package:fabapp/components/textfields.dart';
import 'package:fabapp/components/buttons.dart';
import 'package:fabapp/constants/consts.dart';

class SignInFields extends StatelessWidget {
  SignInFields({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void onSignIn(BuildContext context) {
    // TODO to be replaced by a call to the API
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            AuthContainer(
              child: AuthTextFieldID(
                hintText: 'Identifiant',
                icon: Icon(
                  Icons.person,
                  color: Constants.devinciColor,
                ),
                controller: usernameController,
              ),
            ),
            const SizedBox(height: 20),
            AuthContainer(
              child: AuthTextFieldPsd(
                hintText: 'Mot de passe',
                icon: Icon(
                  Icons.lock,
                  color: Constants.devinciColor,
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 30),
            ClassicRoundButton(
              onTap: () => onSignIn(context),
              text: 'Se connecter',
            ),
          ],
        ),
      ),
    );
  }
}
