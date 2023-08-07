import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/providers/app_provider.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:chat/model/ui/home/home_screen_navigator.dart';

class HomeScreenViewModel extends BaseViewmodel<HomeScreenNavigator> {
  List<Room> room = [];
  void loadRooms() async {
    room = await DatabaseManager.loadRoom();
  }

  List<Room> getMyRooms() {
    String myUserId = AppProvider.myUser?.id ?? '';
    return room.where((room) => room.userId == myUserId).toList();
  }
}
