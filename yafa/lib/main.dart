import 'package:flutter/material.dart';
import 'package:yafa/layouts/main.dart';
import 'package:yafa/pages/login.dart';

void main() {
  runApp(const Yafa());
}

class Yafa extends StatelessWidget {
  const Yafa({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YAFA',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 152, 109, 222)),
        useMaterial3: true,
      ),
      home: const MainLayout(
          title: 'YAFA - Yet Another Forum App', body: LoginPage()),
    );
  }
}
