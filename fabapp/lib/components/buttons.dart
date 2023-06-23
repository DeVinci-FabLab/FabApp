import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

/// Defines a classic button for general purpose
class ClassicButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ClassicButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF65599d),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }
}

class NeoMorphSwitch extends StatefulWidget {
  final String text;

  const NeoMorphSwitch({super.key, required this.text});

  @override
  State<NeoMorphSwitch> createState() => _NeoMorphSwitchState();
}

class _NeoMorphSwitchState extends State<NeoMorphSwitch> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
    Offset distance = isPressed ? const Offset(4, 4) : const Offset(7, 7);
    double blur = isPressed ? 5 : 10;
    return GestureDetector(
        onTap: () => setState(() => isPressed = !isPressed),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: blur,
                  offset: distance,
                  inset: isPressed,
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: -2,
                  blurRadius: blur,
                  offset: -distance,
                  inset: isPressed,
                ),
              ]),
          child: const SizedBox(
            height: 80,
            width: 200,
          ),
        ));
  }
}

/// Defines a custom button with a state on or off
class StateButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isOn;

  const StateButton(
      {super.key, required this.onTap, required this.text, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 280,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1331F5),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOn ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  const LogButton({super.key, required this.onTap, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: color,
          ),
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
