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
    FirebaseAuth
      .instance
      .userChanges()
      .listen((User? user) {
        setState(() {
          _user = user;
        });
      });
  }

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: orange, 
          primary: orange,
          secondary: white,
          background: white,
        ),
        useMaterial3: true,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: red,
          foregroundColor: white,
          iconSize: 36
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(red),
            foregroundColor: MaterialStateProperty.all(white),
            textStyle: MaterialStateProperty.all(buttonTextStyle),
            padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 0, 16, 0)),
            elevation: MaterialStateProperty.all(3.0),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
          )
        ),
      ),
      home: Builder(
        builder: (context) => MainLayout(title: AppLocalizations.of(context)!.appTitle, body: body, user: _user),
      ) 
    );
  }
}