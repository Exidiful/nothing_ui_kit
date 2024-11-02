import 'package:flutter/material.dart';
import 'package:nothing_ui_kit/task_management_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nothing Task Management',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.white, fontFamily: 'DotMatrix'),
          titleLarge: TextStyle(color: Colors.white, fontFamily: 'DotMatrix'),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: const TaskManagementUI(),
    );
  }
}