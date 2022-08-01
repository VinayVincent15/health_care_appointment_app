import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Appointment_queue extends StatefulWidget {

  Appointment_queue({Key? key}) : super(key: key);

  @override
  State<Appointment_queue> createState() => _AppointmentQueue();
}

class _AppointmentQueue extends State<Appointment_queue> {
  final _auth = FirebaseAuth.instance;
  String income="All";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }


  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore=FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40,),

              Expanded(child: StreamBuilder(
                stream: _firestore.collection("Patient").where('status',isEqualTo: "pending").snapshots(),
                builder:  (context, snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  );
                },
              )),
            ],
          ),
        )
    );
  }
}



