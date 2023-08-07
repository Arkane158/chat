import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
 static MyUser? myUser; // Add a question mark to indicate it can be null
  User? fireBaseUser;

  AppProvider() : fireBaseUser = FirebaseAuth.instance.currentUser {
    // Call initMyUser from the constructor to initialize myUser
    if (fireBaseUser != null) {
      initMyUser();
    }
  }

  Future<void> initMyUser() async {
    myUser = await DatabaseManager.readUser(fireBaseUser?.uid ?? '');
    notifyListeners(); // Notify listeners after myUser is initialized
  }

   static getUser() {
    return myUser;
  }
}
