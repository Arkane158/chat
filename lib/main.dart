import 'package:chat/firebase_options.dart';
import 'package:chat/model/providers/app_provider.dart';
import 'package:chat/model/ui/add_room/add_room_screen.dart';
import 'package:chat/model/ui/chat/chat_screen.dart';
import 'package:chat/model/ui/forgot_password/forgot_password_screen.dart';
import 'package:chat/model/ui/home/home_screen.dart';
import 'package:chat/model/ui/login/login_screen.dart';
import 'package:chat/model/ui/signup/sign_up_screen.dart';
import 'package:chat/my_them.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // Wrap your MyApp widget with ChangeNotifierProvider to provide AppProvider
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Provider.of to access the AppProvider
    var provider = Provider.of<AppProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
      routes: {
        LoginScreen.screenName: (context) => const LoginScreen(),
        SignUpScreen.screenName: (context) => const SignUpScreen(),
        HomeScreen.screenName: (context) => const HomeScreen(),
        ForgotPasswordScreen.screenName: (context) =>
            const ForgotPasswordScreen(),
        AddRoomScreen.screenName: (context) => const AddRoomScreen(),
        ChatScreen.screenName: (context) => const ChatScreen(),
      },
      initialRoute: provider.fireBaseUser != null
          ? HomeScreen.screenName
          : LoginScreen.screenName,
    );
  }
}
