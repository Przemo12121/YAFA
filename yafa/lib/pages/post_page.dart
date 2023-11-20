import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yafa/components/comment_dialog.dart';
import 'package:yafa/models/PostModel.dart';
import 'package:yafa/sources/postSource.dart';
import 'package:yafa/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post, required this.user});

  final PostModel post;
  final User user;

  @override
  State<StatefulWidget> createState() => PostPageState(user: user, post: post);
}

class PostPageState extends State<PostPage> {
  PostPageState({required this.user, required this.post});

  final PostModel post;
  final User user;

  @override
  void initState() {
    super.initState();
    syncroniseComments(post.id, (newComment) {
      setState(() {
        post.comments.add(newComment);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(post.title, style: postTitleTextStyle),
                subtitle: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    children: [
                      TextSpan(
                        text: post.author.getDisplayInfo(), 
                        style: TextStyle(color: red),
                      ),
                      TextSpan(text: ", ${post.addedAt.day}.${post.addedAt.month}.${post.addedAt.year}"),
                    ]
                  ),
                ) 
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
                child: Text(post.content)
              )
            ],
          ),
        ),
        const SizedBox(height: 36),
        Text(AppLocalizations.of(context)!.comments, style: listTitleTextStyle),
        ..._mapComments(post),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'back_btn',
                  child: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false)
                ),
                FloatingActionButton(
                  heroTag: 'add_comment_btn',
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (BuildContext context) => CommentDialog(
                      onAccept: (content) async => {
                        if (content.isNotEmpty) {
                          await addComment(post.id, content, user)
                        }
                      }
                    )
                  ),
                  child: const Icon(Icons.comment),
                )
              ]
            )
          )
      ],
    );
  }

  List<Widget> _mapComments(PostModel post) {
    return post.comments.map((e) => Card(
     child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.author.getDisplayInfo(), style: commentAuthorTextStyle),
                const SizedBox(height: 30),
                Text("${e.addedAt.day}.${e.addedAt.month}.${e.addedAt.year}", style: commentContentTextStyle)
              ],
            ),
            Text(e.content, style: commentContentTextStyle)
          ],
        ),
      )     
    )).toList();
  }
}