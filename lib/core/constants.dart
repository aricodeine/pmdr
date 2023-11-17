import 'package:flutter/material.dart';
import 'package:pmdr/screens/home_screen.dart';

const TextStyle kOptionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const double kBottomNavigationIconSize = 35;
const kAppColor = Color(0xff1f1b2e);
const kAppBarSubtextStyle =
    TextStyle(fontSize: 17, color: Color(0xffBCC1CD), fontWeight: FontWeight.w700);
const kTodaysDateStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.bold);
Shadow kShadow = Shadow(
  color: const Color.fromARGB(255, 89, 75, 183).withAlpha(100),
  blurRadius: 20.0,
);
const List<Widget> widgetOptions = <Widget>[
  HomeScreen(),
  Text(
    'Edit timer',
    style: kOptionStyle,
  ),
  Text(
    'Finished tasks',
    style: kOptionStyle,
  ),
  Text(
    'Profile',
    style: kOptionStyle,
  ),
];
