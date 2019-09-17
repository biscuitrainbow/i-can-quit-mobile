import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/widget/smoking_overview/health_regeneration_badge.dart';
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

  Widget _buildOverviewStats(SmokingEntryLoaded state) {
    return Container(
      width: double.infinity,
      color: ColorPalette.primary,
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          OverviewStatsItem.primary(
            title: '200',
            unit: 'วัน',
            description: 'มีอายุยืนขึ้น',
            icon: FontAwesomeIcons.heartbeat,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OverviewStatsItem.secondary(
                title: '+200',
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

  Widget _buildNonSmokingTimePassed(SmokingEntryLoaded state) {
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

  Widget _buildHealthRegenerationList(SmokingEntryLoaded state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('การฟื้นฟูของร่างกาย', style: Styles.titlePrimary),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              HealthRegenerationBadge(
                title: 'ระดับความดันโลหิต',
                duration: Duration(minutes: 1),
                latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
              ),
              HealthRegenerationBadge(
                title: 'ระดับคาร์บอนมอนอกไซด์',
                duration: Duration(hours: 12),
                latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
              ),
              HealthRegenerationBadge(
                title: 'ความเสี่ยงโรคหัวใจ',
                duration: Duration(days: 5),
                latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SmokingEntryBloc smokingEntryBloc = BlocProvider.of<SmokingEntryBloc>(context);

    smokingEntryBloc.dispatch(FetchSmokingEntry());

    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพรวม'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
          bloc: smokingEntryBloc,
          builder: (context, state) {
            if (state is SmokingEntryLoaded) {
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

            if (state is SmokingEntryLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Container();
          }),
    );
  }
}
