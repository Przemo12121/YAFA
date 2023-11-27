import 'package:flutter/material.dart';
import 'package:yafa/components/styled_container.dart';
import 'package:yafa/firebase_utils.dart';
import 'package:yafa/styles.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Text(AppLocalizations.of(context)!.signin, style: titleTextStyle.apply(color: Theme.of(context).colorScheme.secondary)),
            SignInButton(
              Buttons.Google,
              text: AppLocalizations.of(context)!.googleSignIn, 
              onPressed: () async => await signInWithGoogle()
            )
          ]
        ),
      )
    );
  }
}