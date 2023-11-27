import 'package:flutter/material.dart';
import 'package:yafa/layouts/main.dart';
import 'package:yafa/pages/home.dart';
import 'package:yafa/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yafa/styles.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    callback = (dark) => setState(() {
      // _isDarkTheme = dark;
      // _isDarkTheme = !_isDarkTheme;
      isDarkTheme = !isDarkTheme;
    });  

    FirebaseAuth
      .instance
      .userChanges()
      .listen((User? user) {
        setState(() {
          _user = user;
        });
      });
  }


  // void changeTheme(bool dark) {
  //   setState(() {
  //     // _isDarkTheme = dark;
  //     _isDarkTheme = !_isDarkTheme;
  //   });  
  // }

  User? _user;

  @override
  Widget build(BuildContext context) {
    var body = _user == null ? const LoginPage() : HomePage(user: _user!);

    return MaterialApp(
      title: 'YAFA',
      // locale: Locale("en"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("pl"),
        Locale("de"),
      ],
      theme: isDarkTheme ? darkTheme : lightTheme,
      home: Builder(
        builder: (context) => MainLayout(title: AppLocalizations.of(context)!.appTitle, body: body, user: _user),
      ) 
    );
  }
}