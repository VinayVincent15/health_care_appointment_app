import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constrants.dart';
import '../models/Appointment_model.dart';
import '../models/Doctor_model.dart';

class Doctor_ViewPatient  extends StatefulWidget {

  const Doctor_ViewPatient ({Key? key, required this.patientProfile}) : super(key: key);
  final Map<String,dynamic>patientProfile;
  @override
  State<Doctor_ViewPatient> createState() => _Doctor_ViewPatient();
}

class _Doctor_ViewPatient extends State<Doctor_ViewPatient> {
  final auth=FirebaseAuth.instance;
  late User loggedUser;
  List doctorProfile=[];

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
      final user = auth.currentUser!;
      loggedUser = user;
      print("user email");
      print(loggedUser.email);
    }
    catch (e) {
      print(e);
    }
  }

  TextEditingController textEditingController=TextEditingController();
  // @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    fetchDoctor();
  }
  void dispose(){

    super.dispose();
  }
  void openCheckout(){
    var options={
      "key":"rzp_test_yFfqxNtxEQubn7",
      "amount":num.parse(textEditingController.text)*100,
      "name":"Shiksha Anudaan",
      "description":"Donation for the Student Education",
      "prefill":{
        "contact":doctorProfile[0]['phonenum'],
        "email":doctorProfile[0]['email']
      },
      "external":{
        "wallet":["paytm"]
      }
    };
  }
  void handlerPaymentSuccess(){
    print("Payment Success");
    // postDetailsToFirestore();
    Fluttertoast.showToast(
        msg: "PAYMENT SUCCESS",
        toastLength: Toast.LENGTH_SHORT);
  }
  void handlerErrorFailure(){
    print("Payment Failure");
  }
  void handlerExternalWallet(){
    print("External Wallet");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          CircleAvatar(
            minRadius: 60,
            maxRadius: 70,
            backgroundImage: NetworkImage(widget.patientProfile['photourl']),
          ),
          const SizedBox(height: 24,),
          const Text("Personal Information",style: bigTextHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: cyanCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Name : ",style: bigTextHeading,),
                    Text(widget.patientProfile['name'],style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("DOB : ",style: bigTextHeading,),
                    Text(widget.patientProfile['dob'],style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Phone Number : ",style: bigTextHeading,),
                    Text(widget.patientProfile['phonenum'],style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

                const SizedBox(height: 24),


           const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: (){
              opendialog();
            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Get Appointment',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
  Future opendialog()=> showDialog(
    context:context,
    builder:(context)=> AlertDialog(
      title:Center(child: Text('Get Appointment')),
      content:
      TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(hintText: 'Enter Amount'),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          child: Text('Pay'),
          onPressed: () {
            openCheckout();
          },
        ),
      ],
    ),
  );
  // postDetailsToFirestore() async{
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   DateTime dateTime = DateTime.now();
  //   User? user = auth.currentUser;
  //   String day = dateTime.toIso8601String().split('T').first;
  //
  //   AppointmentModel appointmentModel = AppointmentModel();
  //
  //     appointmentModel.doctoremail = doctorProfile[0]['email'];
  //     appointmentModel.patientemail = widget.patientProfile['email'];
  //     appointmentModel.uid = user?.uid;
  //     appointmentModel.starttime = starttime.text;
  //     appointmentModel.endtime = endtime.text;
  //     appointmentModel.reason = reason;
  //     appointmentModel.day = day;
  //
  //   await firebaseFirestore
  //       .collection("Appointments")
  //       .doc(appointmentModel.uid)
  //       .set(appointmentModel.toMap());
  //
  //   Navigator.pop(context);
  //
  // }

}



