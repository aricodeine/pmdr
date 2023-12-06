import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMDR - A Pomodoro App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: kAppColor,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff1f1b2e)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            selectedIconTheme: IconThemeData(
              shadows: [kShadow],
            ),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedItemColor: const Color(0xffFFF6F6),
            selectedItemColor: const Color(0xff664eff)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAppColor,
          splashColor: Color(0xff664eff),
        ),
        canvasColor: Colors.transparent,
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<TimerBloc>(
          create: (BuildContext context) => TimerBloc(),
        ),
      ], child: const HomeScreen()),
    );
  }
}
