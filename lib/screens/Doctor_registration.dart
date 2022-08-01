import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:health_care_appointment_app/screens/Doctor_home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:email_validator/email_validator.dart';
import '../constrants.dart';
import '../models/Doctor_model.dart';

class Doctor_registration extends StatefulWidget {
  const Doctor_registration({Key? key}) : super(key: key);

  @override
  State<Doctor_registration> createState() => _Registration_Doctor();
}

class _Registration_Doctor extends State<Doctor_registration> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _speciality = TextEditingController();
  final TextEditingController _degree = TextEditingController();
  String? dob;
  String availFrom = '00:00';
  String availTo = '00:00';
  String? _gender = 'Male';
  String? photourl = "";
  String? _dayvalue = '';
  String? _monvalue = '';
  String? _yearvalue = '';
  File? _photo;
  bool _isLoading = false;

  Future getPhoto(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 70);
      if (image == null) return;
      final imagePermanent = File(image.path);

      setState(() {
        this._photo = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  Future<File> saveFilePermanentely(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if (value.length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: _name,
              ),
              _buildTextField(
                labelText: 'Email Address',
                validator: (value) {
                  if (EmailValidator.validate(value!) == false) {
                    return "Invalid Email address";
                  }
                  if (value!.isEmpty) {
                    return 'Email address is required';
                  } else {
                    return null;
                  }
                },
                controller: _email,
              ),
              _buildTextField(
                labelText: 'Enter Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 3) {
                    return "Too Short";
                  }
                  if (value.length > 15) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                controller: _password,
              ),
              _buildNumberField(
                labelText: 'Phone Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  if (value.length != 10) {
                    return "Please enter valid phone number";
                  }
                  else {
                    return null;
                  }
                },
                controller: _phonenum,
              ),
              _buildTextField(
                labelText: 'Speciality',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Speciality is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  else {
                    return null;
                  }
                },
                controller: _speciality,
              ),
              _buildTextField(
                labelText: 'Degree',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Degree is required';
                  } else {
                    return null;
                  }
                },
                controller: _degree,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Available from : ",
                      style: TextStyle(color: hintText),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      width: 70,
                      child: DropdownButton<String>(
                        value: availFrom,
                        menuMaxHeight: 400,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 20,
                        elevation: 16,
                        isExpanded: true,
                        style: const TextStyle(color: buttonText),
                        underline: Container(
                          height: 1,
                          color: textBoxText,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            availFrom = newValue!;
                          });
                        },
                        items: <String>[
                          '00:00', '01:00', '02:00', '03:00', '04:00', '05:00',
                          '06:00', '07:00', '08:00', '09:00', '10:00', '11:00',
                          '12:00', '13:00', '14:00', '15:00', '16:00', '17:00',
                          '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        " to ",
                        style: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 70,
                      child: DropdownButton<String>(
                        value: availTo,
                        menuMaxHeight: 400,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 20,
                        elevation: 16,
                        isExpanded: true,
                        style: const TextStyle(color: buttonText),
                        underline: Container(
                          height: 1,
                          color: textBoxText,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            availTo = newValue!;
                          });
                        },
                        items: <String>[
                          '00:00', '01:00', '02:00', '03:00', '04:00', '05:00',
                          '06:00', '07:00', '08:00', '09:00', '10:00', '11:00',
                          '12:00', '13:00', '14:00', '15:00', '16:00', '17:00',
                          '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: const Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: hintText,
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              DropdownDatePicker(
                boxDecoration: BoxDecoration(
                  border: Border.all(color: logoHighlight),
                  borderRadius: BorderRadius.circular(5),
                ),
                isDropdownHideUnderline: true,
                isFormValidator: true,
                startYear: 1950,
                endYear: 2020,
                width: 10,
                onChangedDay: (value) => {_dayvalue = value},
                onChangedMonth: (value) => {_monvalue = value},
                onChangedYear: (value) => {_yearvalue = value},
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  "Gender",
                  style: TextStyle(
                    color: hintText,
                  ),
                ),
              ),
              GenderPickerWithImage(
                showOtherGender: true,
                verticalAlignedText: true,
                selectedGender: Gender.Male,
                selectedGenderTextStyle: const TextStyle(
                    color: Color(0xff008e93), fontWeight: FontWeight.bold),
                unSelectedGenderTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
                onChanged: (Gender? gender) {
                  _gender = gender.toString();
                  _gender = _gender?.replaceAll("Gender.", "");
                  print(_gender);
                },
                equallyAligned: true,
                animationDuration: const Duration(milliseconds: 200),
                isCircular: true,
                // default : true,
                opacityOfGradient: 0.2,
                padding: const EdgeInsets.all(3),
                size: 45,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
          title: 'Profile Picture',
          subtitle: 'To verify the your identity',
          content: Center(
            child: Column(
              children: [
                CustomButton(
                  title: 'Upload your photograph',
                  icon: Icons.image_outlined,
                  onClick: () => getPhoto(ImageSource.gallery),
                ),
                const SizedBox(
                  height: 20,
                ),
                _photo != null
                    ? Image.file(_photo!,
                        width: 250, height: 250, fit: BoxFit.cover)
                    : Image.asset('assets/default_placeholder_image.png'),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          validation: () {}),
      CoolStep(
          title: 'Confirmation',
          subtitle:
              'Recheck the entries you have made. You can change some of them in future',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: _photo != null
                      ? Image.file(_photo!,
                          width: 250, height: 250, fit: BoxFit.cover)
                      : Image.asset('assets/default_placeholder_image.png'),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              apperance(
                title: 'Name',
                value: _name.text,
                a: 99,
              ),
              Container(
                child: Row(
                  children: [
                    const Text(
                      'Date of Birth',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 55,
                    ),
                    Text(
                      '$_dayvalue/$_monvalue/$_yearvalue',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              apperance(
                title: 'Email',
                value: _email.text,
                //a: 135,
                a: 100,
              ),
              apperance(
                title: 'Phone Number',
                value: _phonenum.text,
                a: 76 - 35,
              ),
              apperance(
                title: 'Speciality',
                value: _speciality.text,
                a: 74,
              ),
              apperance(
                title: 'Degree',
                value: _degree.text,
                a: 91,
              ),
              apperance(
                title: 'Gender',
                value: _gender.toString(),
                a: 91,
              ),
              apperance(
                title: 'Availability',
                value: "$availFrom to $availTo",
                a: 67,
              ),
            ],
          ),
          validation: () {}),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        signUp(_email.text, _password.text);
        print('Steps completed!');
      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Doctor Registration",
              style: TextStyle(
                color: logoHighlight,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(child: stepper),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildNumberField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: TextInputType.number,
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Center(child: Text(title))
          ],
        ),
      ),
    );
  }

  Widget apperance({
    required String title,
    required String value,
    required double a,
  }) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            width: a,
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      dob = "${_dayvalue!}/${_monvalue!}/${_yearvalue!}";

      if (_photo == null) {
        Fluttertoast.showToast(msg: "Please upload Profile picture");
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child("DoctorDocs")
            .child('${_phonenum.text}_photo.jpg');
        await ref.putFile(_photo!);
        photourl = await ref.getDownloadURL();

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        postDetailsToFirestore();
      }

      } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    DoctorModel doctorModel = DoctorModel();

    doctorModel.email = user!.email;
    doctorModel.uid = user.uid;
    doctorModel.name = _name.text;
    doctorModel.phonenum = _phonenum.text;
    doctorModel.speciality = _speciality.text;
    doctorModel.degree = _degree.text;
    doctorModel.photourl = photourl;
    doctorModel.availFrom = availFrom;
    doctorModel.availTo = availTo;
    doctorModel.dob = dob;
    doctorModel.gender = _gender;

    await firebaseFirestore
        .collection("Doctor")
        .doc(user.uid)
        .set(doctorModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully!");
    Navigator.push(this.context,
        MaterialPageRoute(builder: (context) => const Doctor_home()));
  }
}
