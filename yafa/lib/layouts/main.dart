import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yafa/firebase_utils.dart';
import 'package:yafa/styles.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.title, required this.body, required this.user});

  final User? user;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    Widget titleText = Text(title, style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18, fontStyle: FontStyle.italic));
    
    if (user != null) {
      // var displayName = user!.displayName != null 
      //   ? user!.displayName!.split(" ")[0]
      //   : user!.email!;
      
      titleText = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText, 
          IconButton(
            icon: Icon(Icons.account_box_rounded, color: red),
            iconSize: 36,
            onPressed: () => signOut(),
          ), 
        ]
      ); 
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
        title: titleText),
      body: body
    );
  }
}
