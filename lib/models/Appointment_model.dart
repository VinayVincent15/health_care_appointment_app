import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel{
  final CollectionReference profilelist= FirebaseFirestore.instance.collection('Doctor');
  String? uid;
  String? doctoremail;
  String? patientemail;
  String? starttime;
  String? endtime;
  String? reason;
  String? status;
  String? day;

  AppointmentModel({this.uid, this.doctoremail, this.patientemail, this.starttime, this.endtime, this.reason, this.status, this.day});
  Future getAppointment(String em)async{
    List appointment=[];
    try{
      await profilelist.where('email',isEqualTo: em).get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          appointment.add(element.data());
        }
      });
      return appointment;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Receiving data from firebase
  factory AppointmentModel.fromMap(map){
    return AppointmentModel(
        uid: map['uid'],
        doctoremail: map['doctorid'],
        patientemail: map['patientid'],
        starttime: map['starttime'],
        endtime: map['endtime'],
        reason: map['reason'],
        status: map['status'],
        day: map['day']
    );
  }

  //Sending data to firebase
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'doctoremail': doctoremail,
      'patientemail': patientemail,
      'starttime': starttime,
      'endtime': endtime,
      'reason': reason,
      'status': status,
      'day': day
    };
  }

}
