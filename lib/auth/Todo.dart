import 'package:firebase_database/firebase_database.dart';

class Todo {
  String key;
  String subject;
  bool completed;
  String userid;

  Todo(this.subject, this.userid, this.completed);

  Todo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userid = snapshot.value["userid"],
        subject = snapshot.value["subject"],
        completed = snapshot.value["completed"];

  toJson() {
    return {
      "userid": userid,
      "subject": subject,
      "completed": completed,
    };
  }
}
