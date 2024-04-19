import 'package:flutter/material.dart';

class DragProvider extends ChangeNotifier {
  String coumpoundString = "";

  bool stateCompound = false;

  bool isSearch = false;

  String resultval = "";

  String isBom = "";

  notifyListeners();
}
