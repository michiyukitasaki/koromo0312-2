import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/ToDo/widget/todo_form_widget.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../provider/todos.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String owner = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '犬友追加',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onChangedOwner: (owener)=>this.owner =owener,
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        owner: owner,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
