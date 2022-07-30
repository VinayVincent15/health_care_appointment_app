import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_appointment_app/constrants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPass_Page extends StatefulWidget {

  const ForgotPass_Page({Key? key}) : super(key: key);

  @override
  State<ForgotPass_Page> createState() => _ForgotPass_PageState();
}

class _ForgotPass_PageState extends State<ForgotPass_Page> {
  // final _auth=FirebaseAuth.instance;
  String email="";
  bool showspinner=false;
  static const String logo = 'assets/Login_logo.png';
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logoHighlight,
      body:  ModalProgressHUD (
        inAsyncCall: showspinner,
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  logo,
                  width: 450,
                  height: 450,
                ),
              ),
              const Center(
                child: Text("Forgot Password",style: bigTextWhiteHeading
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email", style: textCyanheading),
                    const SizedBox(height: 10,
                    ),
                    TextField(
                      onChanged: (value){
                        email=value;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle:const TextStyle(color: hintText),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        fillColor:  textBoxBG,
                        filled: true,
                      ),
                      style: const TextStyle(
                        color: textBoxText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child:ElevatedButton(onPressed: () async{
                        doUserResetPassword();

                        showDialog(context: context, builder:(_)=> AlertDialog(
                          title: const Text("Forgot Password"),
                          content: const Text('Password reset instructions have been sent to email!'),
                          actions: [
                            FloatingActionButton(
                                child: const Text("ok"),
                                onPressed:(){
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                })
                          ],
                        ));
                      },
                        style: ElevatedButton.styleFrom(
                          primary: textBoxBG,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child:  Text('Send Email',
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
              ),
              const SizedBox(height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void doUserResetPassword() async {

    // try{
    //   final passreqeuest =await _auth.sendPasswordResetEmail(email: email);
    //
    //
    // }
    //
    // catch(e) {
    //   AlertDialog(
    //     title: const Text("Forgot Password"),
    //     content: const Text('You are not a registered user!'),
    //     actions: [
    //       FloatingActionButton(
    //           child: const Text("Re enter Email"),
    //           onPressed:(){
    //           })
    //     ],
    //   );
    // }
  }
}