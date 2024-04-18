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

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  late UserProvider userProvider;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bilgileri Güncelle"),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Uyarı:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '* Email değişikliği için e postanıza gelen maili onaylamanız gerekmektedir.',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.fade,
                          maxLines: 4,
                        ),
                        Text(
                          '* Şifre en az 6 karakter uzunluğunda olmalıdır.',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.fade,
                          maxLines: 4,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFiled(
                    "Kullanıcı Adı: ${userProvider.loginUser.username}",
                    _usernameController,
                    false),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled("Email: ${userProvider.loginUser.email}",
                    _emailController, false),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDownButton(
                    changedDrop, userProvider.loginUser.grade!),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled("Yeni Şifre", _passwordController, true),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    update();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 137, 240, 140),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Güncelle",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updatePassword() async {
    User? user = auth.currentUser;
    if (user != null) {
      await user.updatePassword(_passwordController.text);
      await user.verifyBeforeUpdateEmail(_emailController.text);
      showToast(
          message:
              "Email adresinizi doğruladıktan sonra otomaik olarak güncellenecektir.");
    }
  }

  void changedDrop(String newValue) {
    setState(() {
      userProvider.loginUser.grade = newValue;
    });
  }

  void update() async {
    userProvider.isFieldsEmpty(_emailController.text, _usernameController.text,
        _gradeController.text, _passwordController.text);
    print(context.read<UserProvider>().isUpdateButton);
    if (context.read<UserProvider>().isUpdateButton) {
      if (isValidEmail(_emailController.text) &&
          _passwordController.text.length > 6) {
        userProvider.loginUser.email = _emailController.text;
        userProvider.loginUser.username = _usernameController.text;
        print(userProvider.loginUser.grade);
        updatePassword();
        await userProvider.updateUser(userProvider.loginUser);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pop(context);
      } else {
        showToast(message: "Lütfen alanları kontrol edin.");
      }
    } else {
      showToast(message: "Lütfen diğer alanları doldurun");
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
