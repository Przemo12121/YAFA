import 'package:yafa/models/AccountModel.dart';

class CommentModel {
  CommentModel({required this.author, required this.content, required this.subComments});

  final String content;
  final AccountModel author;
  final List<CommentModel> subComments; 
}