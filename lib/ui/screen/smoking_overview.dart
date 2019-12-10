import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/static/static_data.dart';
import 'package:i_can_quit/ui/general/new_user_acknowledgement.dart';
import 'package:i_can_quit/ui/health_regeneration/health_regeneration_item.dart';
import 'package:i_can_quit/ui/screen/health_regeneration/health_regeneration_screen.dart';
import 'package:i_can_quit/ui/widget/navigation_drawer.dart';
import 'package:i_can_quit/ui/widget/smoking_overview/overview_stats_item.dart';
import 'package:i_can_quit/ui/widget/smoking_overview/time_passed.dart';

class SmokingOverviewScreen extends StatefulWidget {
  static const route = '/overview';

  const SmokingOverviewScreen({Key key}) : super(key: key);

  @override
  _SmokingOverviewScreenState createState() => _SmokingOverviewScreenState();
}

class _SmokingOverviewScreenState extends State<SmokingOverviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildOverviewStats(FetchSmokingEntrySuccess state) {
    return Container(
      width: double.infinity,
      color: ColorPalette.primary,
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OverviewStatsItem.secondary(
                title:
                    '${(state.entries.where((entry) => !entry.hasSmoked).length * state.latestUserSetting.pricePerPackage / state.latestUserSetting.numberOfCigarettesPerPackage).toStringAsFixed(2)}',
                unit: 'บาท',
                description: 'มีเงินเก็บเพิ่ม',
                icon: FontAwesomeIcons.piggyBank,
              ),
              VerticalDivider(color: Colors.white, width: 10),
              OverviewStatsItem.secondary(
                title: '${state.nonSmokingDays}',
                unit: 'วัน',
                description: 'วันที่ไม่สูบบุหรี่',
                icon: FontAwesomeIcons.smokingBan,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNonSmokingTimePassed(FetchSmokingEntrySuccess state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: <Widget>[
          Text('ไม่ได้สูบบุหรี่มาแล้ว', style: Styles.titlePrimary),
          SizedBox(height: 16),
          TimePassed(from: state.latestHasSmokedEntry.datetime),
        ],
      ),
    );
  }

  Widget _buildHealthRegenerationList(FetchSmokingEntrySuccess state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('การฟื้นฟูของร่างกาย', style: Styles.titlePrimary),
              GestureDetector(
                child: Text('ดูทั้งหมด', style: Theme.of(context).textTheme.title.copyWith(fontSize: 16, color: Colors.grey.shade500)),
                onTap: () => Navigator.of(context).pushNamed(HealthRegenerationScreen.route),
              )
            ],
          ),
          SizedBox(height: 16),
          ...StaticData.healthRegnerations.take(3).map(
                (healthRegeneration) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: HealthRegenerationItem(
                    healthRegeneration: healthRegeneration,
                    latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพรวม'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: NavigationDrawer(),
      ),
      body: BlocBuilder<SmokingEntryBloc, SmokingEntryState>(builder: (context, state) {
        if (state is FetchSmokingEntrySuccess) {
          if (state.userSettings.isEmpty || state.entries.isEmpty) {
            return NewUserAcknowledgement();
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                children: <Widget>[
                  _buildOverviewStats(state),
                  _buildNonSmokingTimePassed(state),
                  _buildHealthRegenerationList(state),
                ],
              ),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
