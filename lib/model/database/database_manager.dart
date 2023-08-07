import 'package:chat/model/database/models/message.dart';
import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/database/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  static final CollectionReference<MyUser> usersCollection = FirebaseFirestore
      .instance
      .collection(MyUser.collectionName)
      .withConverter<MyUser>(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  // Add a new user to the Firestore collection
  static Future<void> addUser(MyUser user) async {
    return usersCollection.doc(user.id).set(user);
  }

  // Read a user from Firestore based on their ID
  static Future<MyUser?> readUser(String id) async {
    DocumentSnapshot<MyUser> snapshot = await usersCollection.doc(id).get();
    // User found in Firestore, directly return the User object
    return snapshot.data();
  }

  static final CollectionReference<Room> roomCollection = FirebaseFirestore
      .instance
      .collection(Room.collectionName)
      .withConverter<Room>(
        fromFirestore: (snapshot, _) => Room.fromFirestore(snapshot.data()!),
        toFirestore: (room, _) => room.toFirestore(),
      );
  static Future<void> createRoom(Room room) {
    var docref = roomCollection.doc();
    room.id = docref.id;
    return docref.set(room);
  }

  static Future<List<Room>> loadRoom() async {
    var querySnapshot = await roomCollection.get();
    return querySnapshot.docs
        .map((queryDocSnapshot) => queryDocSnapshot.data())
        .toList();
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: ((snapshot, options) =>
                Message.fromFirestore(snapshot.data()!)),
            toFirestore: (message, options) => message.toFirestore());
  }

  static Future<void> sendMessage(Message message, String roomId) {
    var messageDoc = getMessageCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
