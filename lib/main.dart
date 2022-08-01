import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_care_appointment_app/screens/Doctor_home.dart';
import 'package:health_care_appointment_app/screens/Doctor_login.dart';
import 'package:health_care_appointment_app/screens/Doctor_registration.dart';
import 'package:health_care_appointment_app/screens/ForgotPassword.dart';
import 'package:health_care_appointment_app/screens/Patient_home.dart';
import 'package:health_care_appointment_app/screens/Patient_login.dart';
import 'package:health_care_appointment_app/screens/Patient_registration.dart';

import 'Home_Page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        '/d_login': (context) => const Doctor_login(),
        '/d_registration': (context) => const Doctor_registration(),
        '/d_home': (context) => const Doctor_home(),
        '/p_login': (context) => const Patient_login(),
        '/p_registration': (context) => const Patient_registration(),
        '/p_home': (context) => const Patient_home(),
        '/forgot-pass': (context) => const ForgotPass_Page(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
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
