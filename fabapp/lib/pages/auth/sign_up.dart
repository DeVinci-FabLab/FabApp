import 'package:fabapp/api/api_service.dart';
import 'package:fabapp/components/buttons.dart';
import 'package:fabapp/components/textfields.dart';
import 'package:fabapp/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:fabapp/models/signup_request.dart';

class SignUpFields extends StatefulWidget {
  const SignUpFields({super.key});

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late SignUpRequestModel requestModel;

  void createAccount() {
    requestModel.username = usernameController.text;
    requestModel.email = emailController.text;
    requestModel.password = passwordController.text;
    print(requestModel.toJson()); // TODO : supprimer si vériication ok
    ApiService apiService = ApiService();
    apiService.signUp(requestModel).then(
      (value) {
        if (value.email == 'RowNotFound') { // TODO : remplacer gestion de l'erreur par qqch de fonctionnel
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Veuillez réessayer. Nom d\'utilisateur ou mot de passe incorrect.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar( // TODO : remplacer par les étapes de création de compte
            const SnackBar(
              content: Text(
                'Bien authentifié !',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
      },
    );
    
  }

  @override
  void initState() {
    super.initState();
    requestModel = SignUpRequestModel(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        AuthContainer(
          child: AuthTextFieldID(
            hintText: 'Username',
            icon: Icon(
              Icons.person,
              color: Constants.devinciColor,
            ),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        ClassicRoundButton(onTap: createAccount, text: 'Vérifier mon adresse'),
      ],
    );
  }
}
