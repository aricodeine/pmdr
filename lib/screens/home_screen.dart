import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/widgets/app_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerBloc>(context).add(TimerInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        today.day.toString(),
                        style: kTodaysDateStyle,
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('E').format(today), style: kAppBarSubtextStyle),
                          Text(DateFormat('MMM y').format(today), style: kAppBarSubtextStyle),
                        ],
                      )
                    ],
                  ),
                  const AppTitle(title: 'Pomodoro'),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
