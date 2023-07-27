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
}
