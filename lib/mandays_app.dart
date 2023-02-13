import 'package:flutter/material.dart';
import 'package:mandays/pages/home_page.dart';

class MandaysApp extends StatelessWidget {
  const MandaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}