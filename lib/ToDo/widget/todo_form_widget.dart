import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String owner;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedOwner;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.owner = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedOwner,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16),
            buildOwner(),
            SizedBox(height: 8,),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: '犬の名前',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: '犬種類',
        ),
      );
  Widget buildOwner() => TextFormField(
    maxLines: 3,
    initialValue: owner,
    onChanged: onChangedOwner,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: '飼い主情報',
    ),
  );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTodo,
          child: Text('追加'),
        ),
      );
}
