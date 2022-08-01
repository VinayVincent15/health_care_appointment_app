import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constrants.dart';
import '../models/Patient_model.dart';

class Patient_login extends StatefulWidget {

  const Patient_login({Key? key}) : super(key: key);

  @override
  State<Patient_login> createState() => _PLogin_PageState();
}

class _PLogin_PageState extends State<Patient_login> {
  final _auth=FirebaseAuth.instance;
  bool _passwordVisible=false;
  String email="";
  String password="";
  bool showspinner=false;
  static const String logo = 'assets/Login_logo.png';
  bool isChecked=false;
  List patientProfile=[];

  Future<List> getPatient(String em)async{
    dynamic resultant=await PatientModel().getPatient(em);
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        patientProfile=resultant;
      });
    }
    return patientProfile;
  }
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
              const SizedBox(height: 20,
              ),
              Center(
                child: Image.asset(
                  logo,
                  width: 350,
                  height: 350,
                ),
              ),
              const Center(
                child: Text("Patient Login",style: bigTextWhiteHeading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email", style: textCyanheading),
                    const SizedBox(height: 10,),
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
                    const SizedBox(height: 10,
                    ),
                    const Text("Password", style: textCyanheading),
                    const SizedBox(height: 10,
                    ),
                    TextField(
                      onChanged: (value){
                        password=value;
                      },
                      textAlign: TextAlign.center,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {

                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintText: '            Enter your Password',
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
                    Row(
                      children:  [
                        const CheckB(),
                        const Text("Remember Me"),
                        const SizedBox(width: 120,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/forgot-pass');
                          },
                          child: const Text("Forgot Password"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50,),
                    Center(
                      child:ElevatedButton(onPressed: () async{
                        setState((){
                          showspinner=true;
                        });

                        try{
                          final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user!=null ) {
                            await getPatient(email);
                            if(patientProfile.length==1){
                              Navigator.pushNamed(context, '/p_home');
                            }
                            else{
                              throw Exception("Login Failed");
                            }
                          }
                        }
                        catch (error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter correct id and password"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        setState((){
                          showspinner=false;
                        });

                      },
                        style: ElevatedButton.styleFrom(
                          primary: textBoxBG,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child:  Text('Login',
                            style: TextStyle(
                              color: buttonText,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child:ElevatedButton(onPressed: () async{
                        Navigator.pushNamed(context, '/p_registration');
                      },
                        style: ElevatedButton.styleFrom(
                          primary: textBoxBG,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child:  Text('Register',
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
            ],
          ),
        ),
      ),
    );
  }
}


class CheckB extends StatefulWidget {

  const CheckB({Key? key}) : super(key: key);

  @override
  State<CheckB> createState() => _CheckBState();
}

class _CheckBState extends State<CheckB> {
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.cyan;
      }
      return const Color(0xFF323232);
    }
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),

      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

