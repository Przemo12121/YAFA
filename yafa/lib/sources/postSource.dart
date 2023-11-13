import 'package:yafa/models/CommentModel.dart';
import 'package:yafa/models/PostModel.dart';
import 'package:yafa/models/AccountModel.dart';

var _a1 = AccountModel(email: "aaa@bbb.ccc", displayName: "Aaa Bbb");
var _a2 = AccountModel(email: "xyz@xyz.xyz", displayName: "Xyz Xyz");

var _posts = <PostModel>[
  PostModel(author: _a1, 
    title: "Aaa1 bardzo długi tytuł jazda z tym wszystkim w ogole mega koks piloci bombowcow wooooodka", 
    content: "Coś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tamCoś tam", 
    comments: [
      CommentModel(author: _a1, content: "jakis komentarz", addedAt: DateTime.now()),
      CommentModel(author: _a2, content: "jakis komentarz 2", addedAt: DateTime.now()),
      CommentModel(author: _a2, content: "jakis komentarz 3", addedAt: DateTime.now()),
      CommentModel(author: _a2, content: "jakis komentarz 4", addedAt: DateTime.now()),
    ], 
    addedAt: DateTime.now()
  ),
  PostModel(author: _a1, title: "Aaa2", content: "Coś tam 2", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: _a2, title: "Xyz1", content: "Coś tam 3", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: _a1, title: "Aaa3", content: "Coś tam 4", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: _a2, title: "Xyz2", content: "Coś tam 5", comments: List.empty(), addedAt: DateTime.now()),
];

List<PostModel> getPosts(String? search) {
  return search == null || search.isEmpty
    ? _posts
    : _posts.where((p) => p.author.email == search).toList();
}


void savePost(PostModel post) {
  _posts.add(post);
}