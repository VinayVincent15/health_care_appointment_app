import 'package:flutter/material.dart';

// App Title
const kTitle = 'DropDownList';

//Colors
const Color logoHighlight = Color(0xff00c2cb);
const Color lightCyanHeading = Color(0xffe1f5fe);
const Color textBoxBG = Color(0xFFFFE9EF);
const Color buttonText = Color(0xff008e93);
const Color textBoxText = Color(0xff006464);
const Color hintText = Color(0xff797979);

//Text presets
const headingInCard=TextStyle(
    fontSize: 40,
    // color: Color(0xFFAEFEFF),
    color: Colors.white,
    fontWeight: FontWeight.w700
);

const bigTextHeading=TextStyle(
  fontSize: 30,
  color: textBoxText,
  fontWeight: FontWeight.w700,
);

final cyanCard=BoxDecoration(
    color: lightCyanHeading,
    borderRadius: BorderRadius.circular(10)
);

const mainBlackHeading=TextStyle(
    color: Color(0xff0f0f0f),
    fontSize: 25,
    fontWeight: FontWeight.w700
);

const smallBlackHeading=TextStyle(
    color: Color(0xff0f0f0f),
    fontSize: 17,
    fontWeight: FontWeight.w700
);

const textCyanheading=TextStyle(
  color: Color(0xffe1f5fe),
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

const bigTextWhiteHeading=TextStyle(
  fontSize: 40,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

// Drop Down
const kDone = 'Done';
const kSearch = 'Search...';
