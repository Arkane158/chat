import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/user.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:chat/model/ui/signup/signup_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends BaseViewmodel<SignUpNavigator> {
  var auth = FirebaseAuth.instance;
  void signUp(String email, String password, String name) async {
    navigator?.showProgressDialog('Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator?.hideDialog();
      navigator?.showMessage('Account created Successfully',
          posActionTitle: 'Ok');
      MyUser myUser= MyUser (email: email, name: name, id: credential.user?.uid ?? '');
      DatabaseManager.addUser(myUser).then((value) => navigator?.goToHome(myUser));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideDialog();
        navigator?.showMessage('The password provided is too weak.',
            posActionTitle: 'Ok');
      } else if (e.code == 'email-already-in-use') {
        navigator?.hideDialog();
        navigator?.showMessage('The account already exists for that email.',
            posActionTitle: 'Ok');
      }
    } catch (e) {
      navigator?.showMessage(e.toString(), posActionTitle: 'Ok');
    }
  }
}
