import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/widgets/app_title.dart';
import 'package:pmdr/core/widgets/curved_background.dart';
import 'package:pmdr/screens/page_views/tabbar_views/long_break_view.dart';
import 'package:pmdr/screens/page_views/tabbar_views/pomodoro_view.dart';
import 'package:pmdr/screens/page_views/tabbar_views/short_break_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final DateTime today = DateTime.now();
  final _key = GlobalKey<ExpandableFabState>();
  final Color navigationBarColor = Colors.white;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerBloc>(context).add(TimerInitialEvent());
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleExpandableFab() {
    final state = _key.currentState;
    if (state != null) {
      debugPrint('isOpen:${state.isOpen}');
      state.toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
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
        ),
      ),
      body: Stack(
        children: [
          const CurvedBackground(), // Curved background goes here
          SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                PomodoroView(),
                ShortBreakView(),
                LongBreakView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          key: _key,
          overlayStyle: ExpandableFabOverlayStyle(blur: 10),
          distance: 80,
          type: ExpandableFabType.up,
          children: [
            FloatingActionButton.extended(
                onPressed: () {
                  _pageController.animateToPage(0,
                      duration: kNavigationDuration, curve: Curves.easeIn);
                  _toggleExpandableFab();
                },
                label: const Text('Pomodoro')),
            FloatingActionButton.extended(
                onPressed: () {
                  _pageController.animateToPage(1,
                      duration: kNavigationDuration, curve: Curves.easeIn);
                  _toggleExpandableFab();
                },
                label: const Text('Short Break')),
            FloatingActionButton.extended(
                onPressed: () {
                  _pageController.animateToPage(2,
                      duration: kNavigationDuration, curve: Curves.easeIn);
                  _toggleExpandableFab();
                },
                label: const Text('Long Break')),
          ]),
    );
  }
}
