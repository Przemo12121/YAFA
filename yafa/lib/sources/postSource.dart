import 'package:yafa/models/PostModel.dart';
import 'package:yafa/models/AccountModel.dart';

var _posts = <PostModel>[
  PostModel(author: AccountModel(email: "aaa@bbb.ccc", displayName: "Aaa Bbb"), title: "Aaa1 bardzo długi tytuł jazda z tym wszystkim w ogole mega koks piloci bombowcow wooooodka", content: "Coś tam", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: AccountModel(email: "aaa@bbb.ccc", displayName: "Aaa Bbb"), title: "Aaa2", content: "Coś tam 2", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: AccountModel(email: "xyz@xyz.xyz", displayName: "Xyz Xyz"), title: "Xyz1", content: "Coś tam 3", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: AccountModel(email: "aaa@bbb.ccc", displayName: "Aaa Bbb"), title: "Aaa3", content: "Coś tam 4", comments: List.empty(), addedAt: DateTime.now()),
  PostModel(author: AccountModel(email: "xyz@xyz.xyz", displayName: "Xyz Xyz"), title: "Xyz2", content: "Coś tam 5", comments: List.empty(), addedAt: DateTime.now()),
];

List<PostModel> getPosts(String? search) {
  return search == null || search.isEmpty
    ? _posts
    : _posts.where((p) => p.author.email == search).toList();
}
