import 'package:flutter/material.dart';
import 'package:health_care_appointment_app/screens/Doctor_login.dart';
import 'package:health_care_appointment_app/screens/ForgotPassword.dart';
import 'package:health_care_appointment_app/screens/Patient_login.dart';

import 'Home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        '/d_login': (context) => const Doctor_login(),
        '/p_login': (context) => const Patient_login(),
        '/forgot-pass': (context) => const ForgotPass_Page(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Home_Page(),
    );
  }
}
