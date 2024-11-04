import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firestore/models/user.dart';

class FirestoreHandler {
  static CollectionReference<User> getUserCollection() {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection(User.collectionName).withConverter(
      fromFirestore: (snapshot, options) {
        return User.fromFirestore(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> createUser(User user) async {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    docRef.set(user);
  }

  static Future<User?> readUser(String userId) async {
    var collection = getUserCollection();
    var docRef = collection.doc(userId);
    var docSnapshot = await docRef.get();
    return docSnapshot.data();
  }
}
