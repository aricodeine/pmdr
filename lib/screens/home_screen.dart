import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/widgets/app_title.dart';
import 'package:pmdr/core/widgets/dot_indicator.dart';
import 'package:pmdr/screens/page_views/tabbar_views/longg_break_view.dart';
import 'package:pmdr/screens/page_views/tabbar_views/pomodoro_view.dart';
import 'package:pmdr/screens/page_views/tabbar_views/short_break_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final DateTime today = DateTime.now();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<TimerBloc>(context).add(TimerInitialEvent());
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: kBackgroundDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabBar(
                controller: _tabController,
                indicator: const DotIndicator(),
                overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                tabs: const [
                  Tab(
                    text: 'Pomodoro',
                  ),
                  Tab(
                    text: 'Short Break',
                  ),
                  Tab(
                    text: 'Long Break',
                  ),
                ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(child: PomodoroView()),
                SingleChildScrollView(child: ShortBreakView()),
                SingleChildScrollView(child: LongBreakView())
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
