import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/ui/base/base_nav.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  goBack();
}

class AddRoomViewmodel extends BaseViewmodel<AddRoomNavigator> {
  addRoom(String name, String description, String category) async {
    navigator?.showProgressDialog('Loading...');

    try {
      await DatabaseManager.createRoom(
          Room(name: name, description: description, category: category,userId: FirebaseAuth.instance.currentUser?.uid??''));
      navigator?.hideDialog();
      navigator?.showMessage(
        'Room created successfully',
        posActionTitle: 'Ok',
      );
      navigator?.goBack();
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage('Error Creating Room ${e.toString()}',
          posActionTitle: 'Ok');
    }
  }
}
