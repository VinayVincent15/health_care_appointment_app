import 'package:flutter/material.dart';
import '../constrants.dart';
import 'Doctor_ViewPatient.dart';
class Profile_Card extends StatefulWidget {
  const Profile_Card( {Key? key, required this.patientProfileList}) : super(key: key);
  final Map<String,dynamic>patientProfileList;
  @override
  State<Profile_Card> createState() => _Profile_CardState();
}

class _Profile_CardState extends State<Profile_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(this.context, MaterialPageRoute(builder: (context) => Doctor_ViewPatient(patientProfile: widget.patientProfileList,)));
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.only(top: 10),
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Column(
          children:[
            Row(
              children:  [
                Column(
                  children: [
                    CircleAvatar(
                      minRadius: 30,
                      maxRadius: 40,
                      backgroundImage: NetworkImage(widget.patientProfileList['photourl'].toString()),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
                const SizedBox(width: 40,),
                Column(
                  children: [
                    Text(widget.patientProfileList['name'],style:mainBlackHeading),
                    const SizedBox(height: 15,),
                    Row(
                      children:  [
                        const Text("Reason : ",style: smallBlackHeading),
                        Text(widget.patientProfileList['reason']),
                      ],
                    ),
                    Row(
                      children:  [
                        const Text("Time : ", style: smallBlackHeading),
                        Text(widget.patientProfileList['appointmentFrom'].toString()),
                      ],
                    ),
                    Row(
                      children:  [
                        const Text("Status : ", style: smallBlackHeading),
                        Text(widget.patientProfileList['status'].toString()),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

