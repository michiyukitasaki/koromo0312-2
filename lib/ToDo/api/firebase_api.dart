import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todo.dart';
import '../utils.dart';

class FirebaseApi {
  static Future<String>? createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('dogfriends').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>>? readTodos() => FirebaseFirestore.instance
      .collection('dogfriends')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('dogfriends').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('dogfriends').doc(todo.id);

    await docTodo.delete();
  }
}
