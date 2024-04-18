import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';

PreferredSize AppBarCustom(BuildContext context, String text) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      title: Text(text),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          String data = "";
          Provider.of<DrawerProvider>(context, listen: false)
              .changeStateClick(data);
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}
