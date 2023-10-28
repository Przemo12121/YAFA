import 'package:flutter/material.dart';
import 'package:yafa/components/StyledContainer.dart';
import 'package:yafa/firebase_utils.dart';
import 'package:yafa/styles.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StyledContainer(
        height: 80,
        width: 260,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sign in", style: titleTextStyle),
            SignInButton(Buttons.Google, onPressed: () async => await signInWithGoogle())
          ]
        ),
      )
    );
  }
}
