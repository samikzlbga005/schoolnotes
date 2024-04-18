import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  String page = "";

  bool isLoading = false;

  void changeStateClick(String text) {
    page = text;
    print(text);
    notifyListeners();
  }

  void setFalseStateloading() {
    isLoading = false;
    notifyListeners();
  }

  void setTrueStateloading() {
    isLoading = true;
    notifyListeners();
  }

  notifyListeners();
}
