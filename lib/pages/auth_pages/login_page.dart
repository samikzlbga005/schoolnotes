import 'package:schoolnotes/components/auth_components/auth_text_field.dart';
import 'package:schoolnotes/components/auth_components/already_have_account.dart';
import 'package:schoolnotes/components/auth_components/custom_button.dart';
import 'package:schoolnotes/components/form_container_widget.dart';
import 'package:schoolnotes/components/toast_message.dart';
import 'package:schoolnotes/firebase/firebase_auth.dart';
import 'package:schoolnotes/model/User.dart';
import 'package:schoolnotes/pages/home_page.dart';
import 'package:schoolnotes/pages/auth_pages/sign_up_page.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  "Giriş Yap",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFiled("Email", _emailController, false),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled("Şifre", _passwordController, true),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _signIn();
                  },
                  child: CustomButton(_isSigning, "Giriş Yap"),
                ),
                const SizedBox(
                  height: 20,
                ),
                AlreadyHaveAccount(
                    context, SignUpPage(), "Kayıt Ol", "Bir Hesabım Yok")
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    final loginProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      loginProvider.getCurrentUser(user.email!);

      showToast(message: "User is successfully signed in");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      showToast(message: "some error occured");
    }
  }
}
