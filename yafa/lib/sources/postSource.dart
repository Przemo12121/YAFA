import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yafa/models/AccountModel.dart';
import 'package:uuid/uuid.dart';
import 'package:yafa/models/CommentModel.dart';
import 'package:yafa/models/PostModel.dart';
import 'dart:convert';
import 'package:yafa/models/PostTileModel.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
Codec<String, String> stringToBase64 = utf8.fuse(base64);
var idProvider = const Uuid();
var maxAddedAt = 8640000000000000000;

Future<List<PostTileModel>> getPosts(String? search) async {
  return (await database.ref("postTiles")
    .orderByChild("sort_addedAt")
    .get())
    .children
    .map(
      (child) => PostTileModel(
        child.key!, 
        author: AccountModel(
          email: child.child("authorEmail").value as String, 
          displayName: child.child("authorName").value as String, 
        ), 
        title: child.child("title").value as String, 
        addedAt: DateTime.fromMicrosecondsSinceEpoch(child.child("addedAt").value as int)
      )
    )
    .toList();
}

Future<void> addComment(String postId, String content, User commenter) async {
  var addedAt = DateTime.now().microsecondsSinceEpoch;

  await database.ref("comments/$postId")
    .push()
    .set({
      "postId": postId,
      "authorName": commenter.displayName ?? "",
      "authorEmail": commenter.email!,
      "content": content,
      "addedAt": addedAt,
      "sort_AddedAt": maxAddedAt - addedAt,
    });
}

Future<PostModel> getPost(String id) async {
  var postData = (await database.ref("posts/$id").once()).snapshot;

  return PostModel(
    postData.key!, 
    author: AccountModel(
      email: postData.child("authorEmail").value as String,
      displayName: postData.child("authorName").value as String,
    ), 
    title: postData.child("title").value as String, 
    content: postData.child("content").value as String, 
    comments: <CommentModel>[], 
    addedAt: DateTime.fromMicrosecondsSinceEpoch(postData.child("addedAt").value as int)
  );
}

void syncroniseComments(String postId, Function(CommentModel newComment) onNewComment) {
  database
    .ref('comments/$postId')
    .onChildAdded
    .listen((event) { 
      final data = event.snapshot;

      var newComment = CommentModel(
        author: AccountModel(
          email: data.child("authorEmail").value as String,
          displayName: data.child("authorName").value as String,
        ), 
        content: data.child("content").value as String, 
        addedAt: DateTime.fromMicrosecondsSinceEpoch(data.child("addedAt").value as int)
      );

      onNewComment(newComment);
    });
}

Future<void> createNew(User author, String title, String content) async {
  var postId = idProvider.v4();
  var addedAt = DateTime.now().microsecondsSinceEpoch;

  await database
    .ref("posts/$postId")
    .set({
      "authorEmail": author.email!,
      "authorName": author.displayName ?? "",
      "title": title,
      "content": content,
      "addedAt": addedAt
    });
  
  await database
    .ref("postTiles/$postId")
    .set({
      "id": postId,
      "title": title,
      "addedAt": addedAt,
      "authorEmail": author.email,
      "authorName": author.displayName,
      "sort_addedAt": maxAddedAt - addedAt
    });
}