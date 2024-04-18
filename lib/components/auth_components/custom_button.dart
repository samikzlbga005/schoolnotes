import 'package:flutter/material.dart';

Widget CustomButton(bool _isSigning, String text) {
  return Container(
    width: double.infinity,
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: _isSigning
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 137, 240, 140),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
    ),
  );
}
