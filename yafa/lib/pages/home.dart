import 'package:flutter/material.dart';
import 'package:yafa/firebase_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      height: 160,
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        children: [
          const Text("Home", style: TextStyle(fontSize: 28)),
          TextButton(
            child: const Text("Sign out", style: TextStyle(fontSize: 18)),
            onPressed: () => signOut(),
          )
        ]
      ),
    ));
  }
}
