import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:flutter/foundation.dart";

List<String> scopes = ["https://www.googleapis.com/auth/userinfo.email", "https://www.googleapis.com/auth/userinfo.profile"];

Future<UserCredential> signInWithGoogle() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    GoogleSignIn().requestScopes(scopes);

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  else {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    for (var scope in scopes) {
      googleProvider.addScope(scope);
    }

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}

void signOut() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    await GoogleSignIn().signOut();
  }
  
  FirebaseAuth.instance.signOut();
}