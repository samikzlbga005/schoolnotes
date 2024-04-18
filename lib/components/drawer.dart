import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolnotes/components/drawer_buttons.dart';
import 'package:schoolnotes/components/toast_message.dart';
import 'package:schoolnotes/model/User.dart';
import 'package:schoolnotes/pages/auth_pages/login_page.dart';
import 'package:schoolnotes/pages/calculator_pages/calculator_page.dart';
import 'package:schoolnotes/pages/my_topics.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';

import '../pages/auth_pages/update_datas.dart';
import '../provider/user_provider.dart';

Widget drawerHomePage(BuildContext context) {
  var data = context.watch<UserProvider>().loginUser.username ?? "";
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 137, 240, 140),
            ),
            child: Center(
              child: Text(
                "Kullanıcı Adı:  $data",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        CustomDrawerButton(context, UpdatePage(), "Bilgileri Güncelle",
            Provider.of<DrawerProvider>(context, listen: false).page),
        CustomDrawerButton(context, Calculator(), "Hesap Makinesi",
            Provider.of<DrawerProvider>(context, listen: false).page),
        CustomDrawerButton(context, MyTopics(), "Kaydedilen Notlar",
            Provider.of<DrawerProvider>(context, listen: false).page),
        ListTile(
          title: const Text('Çıkış Yap'),
          onTap: () {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.loginUser = ModelUser();
            userProvider.clearLoginUser();
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false);
            showToast(message: "Başarıyla Çıkış Yapıldı");
          },
        ),
      ],
    ),
  );
}
