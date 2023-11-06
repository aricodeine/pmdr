import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmdr/blocs/cubit/homeswitch_cubit.dart';
import 'package:pmdr/core/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int value) {
    BlocProvider.of<HomeSwitchCubit>(context).change(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeSwitchCubit, int>(
          builder: (context, state) {
            return Center(child: widgetOptions[state]);
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeSwitchCubit, int>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timelapse_rounded,
                    size: kBottomNavigationIconSize,
                  ),
                  label: 'Pomodoro',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mode_edit_outline_rounded,
                    size: kBottomNavigationIconSize,
                  ),
                  label: 'Edit Timer',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task_alt_rounded,
                    size: kBottomNavigationIconSize,
                  ),
                  label: 'Finished tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                    size: kBottomNavigationIconSize,
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: state,
              onTap: _onItemTapped,
            );
          },
        ),
      ),
    );
  }
}
