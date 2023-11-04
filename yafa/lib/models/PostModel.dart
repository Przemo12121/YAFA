import 'package:yafa/models/AccountModel.dart';
import 'package:yafa/models/CommentModel.dart';

class PostModel {
  PostModel({ required this.author, required this.title, required this.content, required this.comments, required this.addedAt });
  
  final AccountModel author;
  final String title;
  final String content;
  final List<CommentModel> comments;
  final DateTime addedAt;
}