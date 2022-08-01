import 'package:flutter/material.dart';
// import 'package:siksha_anudan/DonerProfile_Page.dart';
// import 'package:siksha_anudan/History_Page.dart';
// import 'Search_Student_Page.dart';
import 'package:line_icons/line_icons.dart';

import '../constrants.dart';

class Patient_home extends StatefulWidget {
  const Patient_home({Key? key}) : super(key: key);

  @override
  State<Patient_home> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<Patient_home> {
  int currentIndex=0;
  final screens=[
    // SearchDoctors_Page(),
    // HistoryPage(),
    // PatientProfile_Page(),
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
            label: 'Search',
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