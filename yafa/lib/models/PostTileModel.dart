import 'package:uuid/uuid.dart';
import 'package:yafa/models/AccountModel.dart';

class PostTileModel {
  PostTileModel(this.id, { required this.author, required this.title, required this.addedAt });
  
  final String id;
  final AccountModel author;
  final String title;
  final DateTime addedAt;
}