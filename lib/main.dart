import 'package:chat/firebase_options.dart';
import 'package:chat/model/ui/home/home_screen.dart';
import 'package:chat/model/ui/login/login_screen.dart';
import 'package:chat/model/ui/signup/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.screenName: (context) => const LoginScreen(),
        SignUpScreen.screenName: (context) => const SignUpScreen(),
        HomeScreen.screenName: (context) => const HomeScreen(),
      },
      initialRoute: LoginScreen.screenName,
    );
  }
}
