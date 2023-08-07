import 'package:chat/model/ui/base/base_nav.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordViewModel extends BaseViewmodel<ForgotPasswordNavigator> {
  Future forgotPassword(String email) async {
    navigator?.showProgressDialog('Loading...');
    try {
      navigator?.hideDialog();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      navigator?.showMessage('Reset Email Was Sent');
      navigator?.goToLogin();
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage(e.toString());
    }
  }
}

abstract class ForgotPasswordNavigator extends BaseNavigator {
  goToLogin();
}
