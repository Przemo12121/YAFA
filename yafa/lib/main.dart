import 'package:flutter/material.dart';
import 'package:yafa/layouts/main.dart';
import 'package:yafa/pages/home.dart';
import 'package:yafa/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Yafa());
}

class Yafa extends StatefulWidget {
  const Yafa({super.key});

  @override
  State<StatefulWidget> createState() => YafaState();
}

class YafaState extends State<Yafa> {
  YafaState() {
    FirebaseAuth
      .instance
      .userChanges()
      .listen((User? user) {
        if (user == null) {
          print("signed out");
        }
        else {
          print("signed in");
        }

        setState(() {
          _user = user;
        });
      });
  }

  User? _user;

  @override
  Widget build(BuildContext context) {
    var body = _user == null ? const LoginPage() : const HomePage();

    return MaterialApp(
      title: 'YAFA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 152, 109, 222)),
        useMaterial3: true,
      ),
      home: MainLayout(title: 'YAFA - Yet Another Forum App', body: body),
    );
  }
}
