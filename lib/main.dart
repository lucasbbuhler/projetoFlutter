import 'package:flutter/material.dart';
import 'package:primeiroapp/login.dart';
import 'package:primeiroapp/theme.dart';
import 'home.dart';
import 'holiday.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cursos e Feriados',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: _themeMode,
      home: LoginPage(toggleTheme: toggleTheme),
      routes: {
        '/home': (context) => HomePage(toggleTheme: toggleTheme),
        '/holiday': (context) => HolidayScreen(toggleTheme: toggleTheme),
      },
    );
  }
}
