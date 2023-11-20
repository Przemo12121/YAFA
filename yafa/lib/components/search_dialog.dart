import 'package:flutter/material.dart';
import 'package:yafa/styles.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({super.key, required this.onAccept});

  String _title = "";
  String _author = "";
  final void Function(String author, String title) onAccept;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Author:"),
            TextField(autofocus: true, maxLines: null, onChanged: (value) => _author = value),
            const SizedBox(height: 24),
            const Text("Title:"),
            TextField(autofocus: true, maxLines: null, onChanged: (value) => _title = value),
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
                    onAccept(_author, _title); 
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