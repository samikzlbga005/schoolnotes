import 'package:schoolnotes/firebase_options.dart';
import 'package:schoolnotes/pages/auth_pages/login_page.dart';
import 'package:schoolnotes/pages/home_page.dart';
import 'package:schoolnotes/pages/splash_screen.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';
import 'package:schoolnotes/provider/save_topic_provider.dart';
import 'package:schoolnotes/provider/list_lessons_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SaveTopicProvider()),
        ChangeNotifierProvider(create: (context) => ListLessonsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
      ],
      child: MaterialApp(
        title: 'Grade App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
