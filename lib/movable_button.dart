import 'package:flutter/material.dart';

class MovableButton extends StatefulWidget {
  final VoidCallback onTap;

  const MovableButton({required this.onTap, Key? key}) : super(key: key);

  @override
  _MovableButtonState createState() => _MovableButtonState();
}

class _MovableButtonState extends State<MovableButton> {
  Offset position = const Offset(100, 100); // Initial position of the button

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta; // Update button position
          });
        },
        child: FloatingActionButton(
          onPressed: widget.onTap,
          child: const Icon(Icons.bug_report), // Icon for debugging/logs
        ),
      ),
    );
  }
}
