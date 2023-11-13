import 'package:yafa/models/AccountModel.dart';

class CommentModel {
  CommentModel({required this.author, required this.content,required this.addedAt});

  final String content;
  final AccountModel author;
  final DateTime addedAt;
}