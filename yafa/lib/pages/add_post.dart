import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yafa/sources/postSource.dart';
import 'package:yafa/styles.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key, required this.user});

  final User user;
  String _title = "";
  String _content = "";

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var textFieldStyle = TextStyle(color: Theme.of(context).primaryColor);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.createPost, style: listTitleTextStyle.apply(color: Theme.of(context).primaryColor)),
        Card(
          margin: const EdgeInsets.fromLTRB(0, 32, 0, 32),
          child: Container(
            width: 10000,
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.title, style: postTitleTextStyle.apply(color: Theme.of(context).primaryColor)),
                TextField(autofocus: true, maxLines: null, onChanged: (value) => _title = value, style: textFieldStyle),
                Container(height: 78),
                Text(AppLocalizations.of(context)!.content, style: postTitleTextStyle.apply(color: Theme.of(context).primaryColor)),
                TextField(maxLines: null, onChanged: (value) => _content = value, style: textFieldStyle),
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
        AppLocalizations.of(context)!.titleNotEmpty, 
        backgroundColor: Theme.of(context).primaryColor, 
        textStyle: subTextStyle.apply(color: Theme.of(context).colorScheme.tertiary), 
        gravity: Toast.bottom,
        duration: 2
      );
      return;
    }

    await createNew(user, _title, _content);
    Navigator.pop(context, true);
  }
}