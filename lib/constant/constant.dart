import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kPrimaryDarkColor = Color(0xFF6F35A5);

/// title text style
const kTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple,
);

/// subtitle text style
const kSubtitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple,
);

/// body text style
const kBodyTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.blueGrey,
);

/// elevation button style
var kElevationButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.deepPurple,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);
