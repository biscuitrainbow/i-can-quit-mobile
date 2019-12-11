import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/smoking_entry_chart.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/smoking_entry_cluster_map.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class SmokingEntryInsightScreen extends StatefulWidget {
  static final String route = '/smoking_entry_chart';

  @override
  _SmokingEntryInsightScreenState createState() => _SmokingEntryInsightScreenState();
}

class _SmokingEntryInsightScreenState extends State<SmokingEntryInsightScreen> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "กราฟ"),
    new Tab(text: "แผนที่"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                'ข้อมูลเชิงลึก',
                style: TextStyle(color: ColorPalette.primary),
              ),
              floating: true,
              pinned: true,
              iconTheme: IconThemeData(color: ColorPalette.primary),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BubbleTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: ColorPalette.primary,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                tabs: tabs,
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            SmokingEntryChart(),
            SmokingEntryClusterMap(),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'ข้อมูลเชิงลึก',
    //       style: TextStyle(color: ColorPalette.primary),
    //     ),
    //     iconTheme: IconThemeData(color: ColorPalette.primary),
    //     centerTitle: true,
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     bottom: TabBar(
    //       isScrollable: true,
    //       unselectedLabelColor: Colors.grey,
    //       labelColor: Colors.white,
    //       indicatorSize: TabBarIndicatorSize.tab,
    //       indicator: BubbleTabIndicator(
    //         indicatorHeight: 25.0,
    //         indicatorColor: ColorPalette.primary,
    //         tabBarIndicatorSize: TabBarIndicatorSize.tab,
    //       ),
    //       tabs: tabs,
    //       controller: _tabController,
    //     ),
    //   ),
    //   body: TabBarView(
    //     physics: NeverScrollableScrollPhysics(),
    //     controller: _tabController,
    //     children: [
    //       SmokingEntryChart(),
    //       SmokingEntryClusterMap(),
    //     ],
    //   ),
    // );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
