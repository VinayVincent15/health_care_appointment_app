import 'package:flutter/material.dart';
import 'package:health_care_appointment_app/screens/Appointment_queue.dart';
import 'package:line_icons/line_icons.dart';
import '../constrants.dart';
import 'Doctor_profile.dart';

class Doctor_home extends StatefulWidget {
  const Doctor_home({Key? key}) : super(key: key);

  @override
  State<Doctor_home> createState() => _DonerHomeState();
}

class _DonerHomeState extends State<Doctor_home> {
  int currentIndex=0;
  final screens=[
    Appointment_queue(),
    // HistoryPage(),
    Doctor_profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap:(index)=> setState(()=>currentIndex=index) ,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.search),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'Profile',
          ),
        ],
        fixedColor: textBoxText,
        backgroundColor: logoHighlight,
        unselectedItemColor: Colors.white,
      ),
      body: IndexedStack(
        index: currentIndex,
        // children:screens,
      ),
    );
  }
}