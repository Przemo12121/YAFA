import 'package:flutter/material.dart';
import 'package:yafa/styles.dart';

class CommentDialog extends StatelessWidget {
  CommentDialog({super.key, required this.onAccept});

  String _content = "";
  final Future<void> Function(String content) onAccept;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(autofocus: true, maxLines: null, onChanged: (value) => _content = value, style: TextStyle(color: Theme.of(context).primaryColor)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                FloatingActionButton(
                  onPressed: () { 
                    onAccept(_content); 
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.comment),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 

}