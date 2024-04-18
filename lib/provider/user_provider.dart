import 'package:schoolnotes/components/toast_message.dart';
import 'package:schoolnotes/model/User.dart';
import 'package:schoolnotes/service/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final LoginService services = LoginService();

  bool isUpdateButton = false;

  

  ModelUser loginUser = ModelUser();


  

  Future setUser(ModelUser currentUser) async {
    await services.postUser(currentUser);

    notifyListeners();
  }

  Future getCurrentUser(String email) async {
    final res = await services.getCurrentUser(email);
    if (res != null) {
      loginUser = res;
    }
    notifyListeners();
  }

  Future updateUser(ModelUser currentUser) async {
    print(currentUser.email);
    final res = await services.updateUser(currentUser);
    if (res != null) {
      getCurrentUser(currentUser.email!);
    }
    notifyListeners();
  }

  void isFieldsEmpty(String _emailController, String _usernameController,
      String _gradeController, String _passwordController) {
    print(_emailController);
    print(_usernameController);
    print(_passwordController);
    print(_gradeController);
    if (_emailController == "" ||
        _usernameController == "" ||
        _passwordController == "") {
      print("isFiledEmptye geldi");
      isUpdateButton = false;
      notifyListeners();
    } else {
      isUpdateButton = true;
      notifyListeners();
    }
  }

  void clearLoginUser() {
    print(" qwewerwer ${loginUser.notes}");
    notifyListeners();
  }

  notifyListeners();
}
