import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../TextFieldWidget.dart';
import '../constrants.dart';
import '../models/Doctor_model.dart';

class Doctor_profile extends StatefulWidget {

  const Doctor_profile ({Key? key}) : super(key: key);

  @override
  State<Doctor_profile> createState() => _Doctor_profile();
}

class _Doctor_profile extends State<Doctor_profile> {
  final _auth=FirebaseAuth.instance;
  bool status=false;
  late User loggedUser;
  List doctorProfile=[];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchDoctor();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchDoctor()async{
    dynamic resultant=await DoctorModel().getDoctor(loggedUser.email.toString());
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        doctorProfile=resultant;
      });
    }
    return doctorProfile;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedUser = user;
    }
    catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    String phoneNumber=doctorProfile[0]['phonenum'].toString();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          Container(
            height: 200,
            width: 200,
            child:  CircleAvatar(
              minRadius: 30,
              maxRadius: 100,
              backgroundImage: NetworkImage(doctorProfile[0]['photourl'].toString()),
            ),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 150,),
              const Text("Editable ",style: bigTextHeading,),
              const SizedBox(width: 10,),
              FlutterSwitch(
                activeColor: logoHighlight,
                width: 60.0,
                height: 40.0,
                valueFontSize: 15.0,
                toggleSize: 15.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              )
            ],
          ),
          TextFieldWidget(
            label: 'Full Name',
            text:doctorProfile[0]['name'],
            onChanged: (name) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: false,
            label: 'Email',
            text: doctorProfile[0]['email'],
            onChanged: (value) {
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: status,
            label: 'Phone Number',
            text: phoneNumber,
            onChanged: (value) {
              phoneNumber=value;
            },
          ),
          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: () async{
              if(status==true){
                var db = FirebaseFirestore.instance;
                db.collection("Doctor").doc(doctorProfile[0]['uid']).update({'phonenum': phoneNumber});
                setState((){
                  status=false;
                });
              }
            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Save Changes',
                  style: TextStyle(
                    color: buttonText,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: () async{
              _auth.signOut();
              Navigator.pop(context);
            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Log Out',
                  style: TextStyle(
                    color: buttonText,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



