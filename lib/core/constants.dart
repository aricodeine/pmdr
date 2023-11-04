import 'package:flutter/material.dart';

const TextStyle kOptionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const double kBottomNavigationIconSize = 35;
const List<Widget> widgetOptions = <Widget>[
  Text(
    'Pomodoro',
    style: kOptionStyle,
  ),
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
