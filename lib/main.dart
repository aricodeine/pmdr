import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmdr/blocs/cubit/homeswitch_cubit.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
        scaffoldBackgroundColor: const Color(0xff1f1b2e),
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
        canvasColor: Colors.transparent,
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // TRY THIS: Change one of the GoogleFonts
          //           to "lato", "poppins", or "lora".
          //           The title uses "titleLarge"
          //           and the middle text uses "bodyMedium".
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: BlocProvider(
        create: (context) => HomeswitchCubit(),
        child: const HomeScreen(),
      ),
    );
  }
}
