import 'package:flutter/material.dart';

Widget AlreadyHaveAccount(
    BuildContext context, Widget widget, String text, String val) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        val,
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget),
            (route) => false,
          );
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ],
  );
}
