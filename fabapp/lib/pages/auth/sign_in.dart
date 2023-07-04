import 'package:flutter/material.dart';

import 'package:fabapp/components/textfields.dart';
import 'package:fabapp/components/buttons.dart';
import 'package:fabapp/constants/consts.dart';

class SignInFields extends StatelessWidget {
  SignInFields({super.key});

  final idController = TextEditingController();
  final psdController = TextEditingController();

  void onSignIn(BuildContext context) {
    // TODO to be replaced by a call to the API
    if (idController.text == 'admin' && psdController.text == 'secret') {
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
            const SizedBox(height: 60),
            AuthContainer(
              child: AuthTextFieldID(
                hintText: 'Identifiant',
                icon: Icon(
                  Icons.person,
                  color: Constants.devinciColor,
                ),
                controller: idController,
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
                controller: psdController,
              ),
            ),
            const SizedBox(height: 30),
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
                      color: Color(0xFF65599d),
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
