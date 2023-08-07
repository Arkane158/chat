import 'package:chat/model/providers/app_provider.dart';
import 'package:chat/model/ui/dialoge_utils.dart';
import 'package:flutter/material.dart';

import '../../database/models/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return AppProvider.myUser?.id == message.senderId
        ? SentMessage(message: message)
        : ReceivedMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0), // Adjusted margin
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.content!,
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
                const SizedBox(height: 4),
                Text(
                  formatMessageDate(message.dateTime!),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0), // Adjusted margin
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.senderName ?? '',
                  style: const TextStyle(color: Color(0xff787993)),
                ),
                Text(
                  message.content!,
                  style:
                      const TextStyle(color: Color(0xff787993), fontSize: 19),
                ),
                const SizedBox(height: 4),
                Text(
                  formatMessageDate(message.dateTime!),
                  style:
                      const TextStyle(color: Color(0xff787993), fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
