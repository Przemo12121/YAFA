import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yafa/sources/postSource.dart';
import 'package:yafa/styles.dart';
import 'package:toast/toast.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key, required this.user});

  final User user;
  String _title = "";
  String _content = "";

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create new post", style: listTitleTextStyle),
        Card(
          margin: const EdgeInsets.fromLTRB(0, 32, 0, 32),
          child: Container(
            width: 10000,
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title:", style: postTitleTextStyle),
                TextField(autofocus: true, maxLines: null, onChanged: (value) => _title = value),
                Container(height: 78),
                Text("Content:", style: postTitleTextStyle),
                TextField(maxLines: null, onChanged: (value) => _content = value),
              ],
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: 'back_btn',
              child: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)
            ),
            FloatingActionButton(
              heroTag: 'create_btn',
              child: const Icon(Icons.create),
              onPressed: () => _handleSubmit(context, user)
            ),
          ],
        ),
      ]
    );
  }

  void _handleSubmit(BuildContext context, User user) async {
    if (_title.isEmpty) {
      Toast.show(
        "Title cannot be empty.", 
        backgroundColor: orange, 
        textStyle: subTextStyle, 
        gravity: Toast.bottom,
        duration: 2
      );
      return;
    }

    await createNew(user, _title, _content);
    Navigator.pop(context, true);
  }
}