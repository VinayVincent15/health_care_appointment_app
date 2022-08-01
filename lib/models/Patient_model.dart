import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel{
  final CollectionReference profilelist= FirebaseFirestore.instance.collection('Patient');
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? photourl;
  String? dob;
  String? gender;

  PatientModel({this.uid, this.name, this.email, this.phonenum, this.photourl, this.dob, this.gender});
  Future getPatient(String em)async{
    List patient=[];
    try{
      await profilelist.where('email',isEqualTo: em).get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          patient.add(element.data());
        }
      });
      return patient;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Receiving data from firebase
  factory PatientModel.fromMap(map){
    return PatientModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        phonenum: map['phonenum'],
        photourl: map['photourl'],
        dob: map['dob'],
        gender: map['gender']
    );
  }

  //Sending data to firebase
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'name': name,
      'email': email,
      'phonenum': phonenum,
      'photourl': photourl,
      'dob': dob,
      'gender': gender
    };
  }

}
