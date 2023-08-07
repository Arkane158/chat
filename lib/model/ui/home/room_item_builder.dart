import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomItemBuilder extends StatelessWidget {
  final Room room;
  const RoomItemBuilder({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.screenName, arguments: room);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/${room.category?.toLowerCase()}.png',
                height: MediaQuery.of(context).size.height * .09,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${room.name}',
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
