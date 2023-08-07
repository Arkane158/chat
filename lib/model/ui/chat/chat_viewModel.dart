import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/message.dart';
import 'package:chat/model/providers/app_provider.dart';
import 'package:chat/model/ui/chat/chat_nav.dart';

import 'package:chat/model/ui/base/base_viewmodel.dart';

class ChatViewModel extends BaseViewmodel<ChatNavigator> {
  send(String messageContent, String roomId) async {
    Message message = Message(
        content: messageContent,
        senderId: AppProvider.myUser?.id,
        senderName: AppProvider.myUser?.name,
        roomId: roomId,
        dateTime: DateTime.now().microsecondsSinceEpoch);
    try {
      await DatabaseManager.sendMessage(message, roomId);
      navigator?.clearText();
    } catch (e) {
      navigator?.showMessage(e.toString(), posActionTitle: 'Try Again',
          posAction: () {
        send(messageContent, roomId);
      }, negActionTitle: 'Ok');
    }
  }
}
