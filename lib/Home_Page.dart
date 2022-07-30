import 'package:flutter/material.dart';

import 'constrants.dart';

class Home_Page extends StatelessWidget {
  static const String logo = 'assets/Home_logo.png';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 120,
          ),
          Image.asset(
            logo,
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                //color: Colors.,
                color: logoHighlight,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Welcome", style: bigTextWhiteHeading),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 50),
                    child: Text(
                      '"Greatest wealth is health"',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: lightCyanHeading,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                            Navigator.pushNamed(context, '/d_login');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: textBoxBG,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Doctor',
                            style: TextStyle(
                              color: buttonText,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/p_login');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: textBoxBG,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Patient',
                            style: TextStyle(
                              color: buttonText,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
