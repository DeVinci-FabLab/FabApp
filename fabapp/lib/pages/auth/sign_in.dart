import 'package:fabapp/api/api_service.dart';
import 'package:fabapp/models/login_request.dart';
import 'package:flutter/material.dart';

import 'package:fabapp/components/textfields.dart';
import 'package:fabapp/components/buttons.dart';
import 'package:fabapp/constants/consts.dart';

class SignInFields extends StatefulWidget {
  const SignInFields({super.key});

  @override
  State<SignInFields> createState() => _SignInFieldsState();
}

class _SignInFieldsState extends State<SignInFields> {
  final idController = TextEditingController();
  final psdController = TextEditingController();

  late LoginRequestModel requestModel;

  void onSignIn(BuildContext context) {
    requestModel.email = idController.text;
    requestModel.password = psdController.text;
    ApiService apiService = ApiService();
    apiService.login(requestModel).then(
      (value) {
        if (value.token == 'RowNotFound') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Veuillez réessayer. Nom d\'utilisateur ou mot de passe incorrect.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          print(value.token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
    );

  }

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel(
      email: idController.text,
      password: psdController.text,
    );
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }
}
