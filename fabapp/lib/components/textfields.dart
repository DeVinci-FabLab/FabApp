import 'package:flutter/material.dart';

import 'package:fabapp/constants/consts.dart';

/// Defines a custom textfield to enter an id or a password
class CustomTextField extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF65599d)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: labelText,
        ),
      ),
    );
  }
}

class AuthContainer extends StatelessWidget {
  final Widget child;
  const AuthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Constants.devinciColorLigth,
          borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}

class AuthTextFieldID extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final dynamic controller;

  const AuthTextFieldID({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}

class AuthTextFieldPsd extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final dynamic controller;

  const AuthTextFieldPsd({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
  });

  @override
  State<AuthTextFieldPsd> createState() => _AuthTextFieldPsdState();
}

class _AuthTextFieldPsdState extends State<AuthTextFieldPsd> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText, // Utilisez la valeur de l'état du widget
      decoration: InputDecoration(
        icon: widget.icon,
        hintText: widget.hintText,
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              // Mettre à jour l'état de la visibilité du texte
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
