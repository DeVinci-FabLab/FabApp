import 'package:fabapp/components/buttons.dart';
import 'package:fabapp/components/textfields.dart';
import 'package:fabapp/constants/consts.dart';
import 'package:flutter/material.dart';

class SignUpFields extends StatelessWidget {
  SignUpFields({super.key});

  final emailController = TextEditingController();

  void sendCode() {
    // TODO to be replaced by a call to the API
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        AuthContainer(
          child: AuthTextFieldID(
            hintText: 'Email',
            icon: Icon(
              Icons.email,
              color: Constants.devinciColor,
            ),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 40),
        ClassicRoundButton(onTap: sendCode, text: 'Vérifier mon adresse'),
      ],
    );
  }
}
