import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';

Widget CustomDrawerButton(
    BuildContext context, Widget widget, String text, String val) {
  return ListTile(
    title: Text(text),
    onTap: val != text
        ? () {
            if (val != text) {
              Navigator.of(context).pop();
              Provider.of<DrawerProvider>(context, listen: false)
                  .changeStateClick(text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget),
              );
            }
          }
        : null,
  );
}
