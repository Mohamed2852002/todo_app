import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = 'Tasks';
  String? id;
  String? title;
  String? description;
  Timestamp? date;
  bool isDone;
  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.isDone = false,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'Id': id,
      'Title': title,
      'Description': description,
      'Date': date,
      'IsDone': isDone,
    };
  }

  factory Task.fromFirestore(Map<String, dynamic>? data) {
    return Task(
      id: data?['Id'],
      title: data?['Title'],
      description: data?['Description'],
      date: data?['Date'],
      isDone: data?['IsDone'],
    );
  }
}
