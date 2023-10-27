import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yafa/firebase_utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          const Text("Sign in", style: TextStyle(fontSize: 28)),
          TextButton(
            child: const Text("Sign in", style: TextStyle(fontSize: 18)),
            onPressed: () async => await signInWithGoogle(),
            // onPressed: () => FirebaseAuth.instance.signInWithRedirect(GoogleAuthProvider()),
          )
        ]),
    ));
  }
}
