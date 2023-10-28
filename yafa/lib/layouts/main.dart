import 'package:flutter/material.dart';
import 'package:yafa/styles.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
        centerTitle: true,
        title: Text(title, style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18, fontStyle: FontStyle.italic)),
      ),
      body: body
    );
  }
}
