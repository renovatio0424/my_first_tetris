import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pixel extends StatelessWidget {
  var color;
  var child;

  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.all(1),
      child: const Center(
        child: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
