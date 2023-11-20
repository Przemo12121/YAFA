import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yafa/models/AccountModel.dart';
import 'package:uuid/uuid.dart';
import 'package:yafa/models/CommentModel.dart';
import 'package:yafa/models/PostModel.dart';
import 'dart:convert';
import 'package:yafa/models/PostTileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseDatabase realTimeDatabase = FirebaseDatabase.instance;
// FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
Codec<String, String> stringToBase64 = utf8.fuse(base64);
var idProvider = const Uuid();
var maxAddedAt = 8640000000000000000;

Future<List<PostTileModel>> getPosts(String? searchAuthor, String? searchTitle) async {
  var posts = (await realTimeDatabase.ref("postTiles")
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
    );
    
  if (searchAuthor != null && searchAuthor.isNotEmpty) {
    posts = posts.where((post) => post.author.email.contains(searchAuthor));
  }
  if (searchTitle != null && searchTitle.isNotEmpty) {
    posts = posts.where((post) => post.title.toLowerCase().contains(searchTitle.toLowerCase()));
  }

  return posts.toList();
  // firestore indexes issue
  // var query = firestoreDatabase.collection("postTiles")
  //   .orderBy("addedAt", descending: true)
  //   .where("authorEmail", isEqualTo: "250147@student.pwr.edu.pl");

  // // if (searchAuthor != null && searchAuthor.isNotEmpty) {
  // //   query = query
  // //     .where("authorEmail", arrayContains: searchAuthor);
  // //     // .where('authorEmail', isGreaterThanOrEqualTo: searchAuthor)
  // //     // .where('authorEmail', isLessThan: searchAuthor+'z');
  // // }

  // return (await query.get()).docs.map(
  //   (doc) => PostTileModel(
  //     doc.get("id") as String, 
  //     author: AccountModel(
  //       email: doc.get("authorEmail") as String,
  //       displayName: doc.get("authorName") as String
  //     ), 
  //     title: doc.get("title") as String, 
  //     addedAt: DateTime.fromMicrosecondsSinceEpoch(doc.get("addedAt") as int)
  //   )
  // ).toList();

  // return await firestoreDatabase
  //   .collection("postTiles")

  //   .get(GetOptions());
}

Future<void> addComment(String postId, String content, User commenter) async {
  var addedAt = DateTime.now().microsecondsSinceEpoch;

  await realTimeDatabase.ref("comments/$postId")
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
  var postData = (await realTimeDatabase.ref("posts/$id").once()).snapshot;

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
  realTimeDatabase
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

  await realTimeDatabase
    .ref("posts/$postId")
    .set({
      "authorEmail": author.email!,
      "authorName": author.displayName ?? "",
      "title": title,
      "content": content,
      "addedAt": addedAt
    });

  await realTimeDatabase
    .ref("postTiles/$postId")
    .set({
      "id": postId,
      "title": title,
      "addedAt": addedAt,
      "authorEmail": author.email,
      "authorName": author.displayName,
      "sort_addedAt": maxAddedAt - addedAt
    });
  
  // await firestoreDatabase
  //   .collection("postTiles")
  //   .add({
  //     "id": postId,
  //     "title": title,
  //     "addedAt": addedAt,
  //     "authorEmail": author.email,
  //     "authorName": author.displayName,
  //   });
}