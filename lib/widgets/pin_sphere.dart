import 'package:flutter/material.dart';

class PinSphere extends StatelessWidget {
  final bool input;

  const PinSphere({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: input ? const Color(0xFFF0674C) : const Color(0xFFE2E5EA),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
