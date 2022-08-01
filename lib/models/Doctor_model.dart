import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel{
  final CollectionReference profilelist= FirebaseFirestore.instance.collection('Doctor');
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? speciality;
  String? degree;
  String? photourl;
  String? availFrom;
  String? availTo;
  String? dob;
  String? gender;

  DoctorModel({this.uid, this.name, this.email, this.phonenum, this.speciality, this.degree,
    this.photourl, this.availFrom, this.availTo, this.dob, this.gender});
  Future getDoctor(String em)async{
    List doctor=[];
    try{
      await profilelist.where('email',isEqualTo: em).get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          doctor.add(element.data());
        }
      });
      return doctor;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Receiving data from firebase
  factory DoctorModel.fromMap(map){
    return DoctorModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        phonenum: map['phonenum'],
        speciality: map['speciality'],
        degree: map['degree'],
        photourl: map['photourl'],
        availFrom: map['availFrom'],
        availTo: map['availTo'],
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
      'speciality': speciality,
      'degree': degree,
      'photourl': photourl,
      'availFrom': availFrom,
      'availTo': availTo,
      'dob': dob,
      'gender': gender
    };
  }

}
