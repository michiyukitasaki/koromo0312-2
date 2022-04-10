import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/todo.dart';
import '../page/edit_todo_page.dart';
import '../provider/todos.dart';
import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(
              key: Key(todo.id!),
            ),
            children: [
              SlidableAction(
              backgroundColor: Colors.green,
              label: '編集',
              icon: Icons.edit,
                onPressed: (BuildContext context) { editTodo(context, todo); },
            )],
          ),

          endActionPane: ActionPane(
            motion: ScrollMotion(
              key: Key(todo.id!),
            ),
            children: [
              SlidableAction(
                backgroundColor: Colors.red,
                label: '削除',
                icon: Icons.delete,
                onPressed: (BuildContext context) { deleteTodo(context, todo); },
              )],
          ),

          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.brown[100],
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  Checkbox(
                    // activeColor: Theme.of(context).primaryColor,
                    activeColor: Colors.white,
                    checkColor: Colors.brown,
                    value: todo.isDone,
                    onChanged: (_) {
                      final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                      final isDone = provider.toggleTodoStatus(todo);

                      // Utils.showSnackBar(
                      //   context,
                      //   isDone ? '多摩川付近' : 'それ以外',
                      // );
                    },
                  ),
                  Text('多摩川付近'),
                  Text('でなければ'),
                  Text('チェック'),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '犬名前：${todo.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '犬種類：${todo.description}',
                          style: TextStyle(fontSize: 20, height: 1.5,color: Colors.black),
                        ),
                      ),
                    if (todo.owner.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '飼い主特徴：${todo.owner}',
                          style: TextStyle(fontSize: 20, height: 1.5,color: Colors.black),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    // Utils.showSnackBar(context, '友達削除');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
