import 'package:schoolnotes/components/auth_components/already_have_account.dart';
import 'package:schoolnotes/components/auth_components/auth_text_field.dart';
import 'package:schoolnotes/components/auth_components/custom_button.dart';
import 'package:schoolnotes/components/auth_components/drow_down_button.dart';
import 'package:schoolnotes/components/form_container_widget.dart';
import 'package:schoolnotes/components/toast_message.dart';
import 'package:schoolnotes/firebase/firebase_auth.dart';
import 'package:schoolnotes/model/User.dart';
import 'package:schoolnotes/pages/auth_pages/login_page.dart';
import 'package:schoolnotes/pages/home_page.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  bool isSigningUp = false;
  String dropValue = "9. Sınıf";

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void changedDrop(String newValue) {
    setState(() {
      dropValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 137, 240, 140),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Kayıt Ol",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFiled("Kullanıcı Adı", _usernameController, false),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled("Email", _emailController, false),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDownButton(changedDrop, dropValue),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled("Şifre", _passwordController, true),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      _signUp();
                    },
                    child: CustomButton(isSigningUp, "Kayıt Ol")),
                const SizedBox(
                  height: 20,
                ),
                AlreadyHaveAccount(context, LoginPage(), "Giriş Yap",
                    "Zaten bir hesabın var mı?")
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      final loginProvider = Provider.of<UserProvider>(context, listen: false);

      loginProvider.loginUser.email = user.email;
      loginProvider.loginUser.grade = dropValue;
      loginProvider.loginUser.username = username;
      List<String> notes = [];

      await loginProvider.setUser(loginProvider.loginUser);
      showToast(message: "Başarı ile Kayıt Yaptınız");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      showToast(message: "Some error happend");
    }
  }
}
