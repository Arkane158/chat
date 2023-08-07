import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/user.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:chat/model/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewmodel<LoginNavigator> {
  var auth = FirebaseAuth.instance;
  void login(String email, String password) async {
    try {
      navigator?.showProgressDialog('Loading...');

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      navigator?.hideDialog();
      // navigator?.showMessage('Login Successful', posActionTitle: 'Ok');
      MyUser? myUser =
          await DatabaseManager.readUser(credential.user?.uid ?? '');
      if (myUser?.id != null) {
        navigator?.goToHome(myUser!);
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideDialog();

      if (e.code == 'user-not-found') {
        navigator?.showMessage('No user found for that email.',
            posActionTitle: 'Ok');
      } else if (e.code == 'wrong-password') {
        navigator?.showMessage('Wrong password provided for that user.',
            posActionTitle: 'Ok');
      } else {
        navigator?.showMessage('something went wrong', posActionTitle: 'Ok');
      }
    }
  }
}
