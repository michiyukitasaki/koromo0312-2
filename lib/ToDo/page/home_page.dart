import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/firebase_api.dart';
import '../main.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import '../widget/add_todo_dialog_widget.dart';
import '../widget/completed_list_widget.dart';
import '../widget/todo_list_widget.dart';

class ToDoHomePage extends StatefulWidget {
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('犬友リスト'),
        // bottom: PreferredSize(
        //     child: Container(
        //       child: Column(
        //         children: [
        //           Text('左にスライドで編集'),
        //           Text('右にスライドで削除')
        //         ],
        //       ),
        //       height: 50, //高さ
        //       color: Colors.brown[400], //色
        //     ),
        //     preferredSize: Size.fromHeight(5)),//高さ
        backgroundColor: Colors.brown,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.brown[300],
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: '多摩川付近',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_disabled, size: 28),
            label: 'それ以外',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos!);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.brown,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add,color: Colors.white70,),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
