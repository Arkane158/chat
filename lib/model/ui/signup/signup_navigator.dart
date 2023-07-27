import 'package:chat/model/database/models/user.dart';
import 'package:chat/model/ui/base/base_nav.dart';

abstract class SignUpNavigator extends BaseNavigator {
  goToHome(MyUser myUser);
}
