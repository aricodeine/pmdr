import 'package:flutter/material.dart';
import 'package:pmdr/screens/pomodoro_view.dart';

const TextStyle kOptionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const double kBottomNavigationIconSize = 35;
Shadow kShadow = Shadow(
  color: const Color.fromARGB(255, 89, 75, 183).withAlpha(100),
  blurRadius: 20.0,
);
const List<Widget> widgetOptions = <Widget>[
  PomodoroView(),
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
