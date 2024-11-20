import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firestore/models/task.dart';
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

  static CollectionReference<Task> getTaskCollection(String userId) {
    var collection = getUserCollection()
        .doc(userId)
        .collection(Task.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromFirestore(snapshot.data()),
          toFirestore: (value, options) => value.toFirestore(),
        );
    return collection;
  }

  static Future<void> createTask(Task task, String userId) async {
    var collection = getTaskCollection(userId);
    var docRef = collection.doc();
    task.id = docRef.id;
    docRef.set(task);
  }

  static Stream<List<Task>> getSortedTasks(
      String userId, DateTime selectedDate) async* {
    selectedDate = selectedDate.copyWith(
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
    var taskCollection = getTaskCollection(userId).where(
      'Date',
      isEqualTo: Timestamp.fromDate(selectedDate),
    );
    var snapshotList = taskCollection.snapshots();
    var tasksList = snapshotList.map(
      (event) => event.docs
          .map(
            (e) => e.data(),
          )
          .toList(),
    );
    yield* tasksList;
  }

  static Stream<List<Task>> getAllTasks(String userId) async* {
    var taskCollection = getTaskCollection(userId).orderBy('Date');
    var snapshotList = taskCollection.snapshots();
    var tasksList =
        snapshotList.map((event) => event.docs.map((e) => e.data()).toList());
    yield* tasksList;
  }

  static Future<void> updateTask(
      String userId, String taskId, Map<String, dynamic> data) async {
    var taskCollection = getTaskCollection(userId);
    taskCollection.doc(taskId).update(data);
  }

  static Future<void> deleteTask(String userId, String taskId) async {
    var taskCollection = getTaskCollection(userId);
    taskCollection.doc(taskId).delete();
  }
}
