import 'package:chat/model/database/database_manager.dart';
import 'package:chat/model/database/models/message.dart';
import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/chat/chat_nav.dart';
import 'package:chat/model/ui/chat/chat_viewModel.dart';
import 'package:chat/model/ui/chat/message_widget.dart';
import 'package:chat/model/ui/dialoge_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String screenName = 'chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  @override
  ChatViewModel initViewmodel() {
    return ChatViewModel();
  }

  late Room room;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_bg.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              appBar: AppBar(
                title: Text('${room.name}'),
              ),
              body: Card(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .03,
                    horizontal: MediaQuery.of(context).size.width * .03),
                color: Colors.white,
                elevation: 15,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream:
                          DatabaseManager.getMessageCollection(room.id ?? '')
                              .orderBy('dateTime', descending: false)
                              .snapshots(),
                      builder: (buildContext, asyncSnapshot) {
                        if (asyncSnapshot.hasError) {
                          DialogeUtils.showMessage(
                              context, 'Something went wrong');
                        }
                        if (asyncSnapshot == ConnectionState.waiting) {
                          DialogeUtils.showProgressDialog(
                              context, 'Loading...');
                        }
                        var data = asyncSnapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        return ListView.builder(
                          itemBuilder: (buildContext, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MessageWidget(message: data![index]),
                            );
                          },
                          itemCount: data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(25))),
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Message',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            if (messageController.text.trim().isNotEmpty) {
                              viewModel.send(
                                  messageController.text, room.id ?? '');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    'send',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            )));
  }

  @override
  clearText() {
    messageController.clear();
  }
}
