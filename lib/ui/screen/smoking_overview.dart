import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/static/static_data.dart';
import 'package:i_can_quit/ui/screen/health_regeneration/health_regeneration_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_first_setting_screen.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/navigation_drawer.dart';
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

  Widget _buildOverviewStats(FetchSmokingEntrySuccess state) {
    return Container(
      width: double.infinity,
      color: ColorPalette.primary,
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // OverviewStatsItem.primary(
          //   title: '200',
          //   unit: 'วัน',
          //   description: 'มีอายุยืนขึ้น',
          //   icon: FontAwesomeIcons.heartbeat,
          // ),
          // SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlocBuilder<UserSettingBloc, UserSettingState>(
                builder: (context, userSettingState) {
                  return BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
                    builder: (context, smokingEntryState) {
                      if (userSettingState is FetchUserSettingSuccess && smokingEntryState is FetchSmokingEntrySuccess) {
                        return OverviewStatsItem.secondary(
                          title:
                              '${(smokingEntryState.entries.where((entry) => !entry.hasSmoked).length * userSettingState.latestSetting.pricePerPackage / userSettingState.latestSetting.numberOfCigarettesPerPackage).toStringAsFixed(2)}',
                          unit: 'บาท',
                          description: 'มีเงินเก็บเพิ่ม',
                          icon: FontAwesomeIcons.piggyBank,
                        );
                      }
                    },
                  );

                  //return Container();
                },
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
                child: Text('ดูทั้งหมด', style: Styles.descriptionSecondary),
                onTap: () => Navigator.of(context).pushNamed(HealthRegenerationScreen.route),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: StaticData.healthRegnerations.length,
              itemBuilder: (context, index) {
                final healthRegeneration = StaticData.healthRegnerations[index];

                return HealthRegenerationBadge(
                  title: healthRegeneration.title,
                  duration: healthRegeneration.duration,
                  latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SmokingEntryBloc smokingEntryBloc = BlocProvider.of<SmokingEntryBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพรวม'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: NavigationDrawer(),
      ),
      body: BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
          bloc: smokingEntryBloc,
          builder: (context, smokingEntryState) {
            return BlocBuilder<UserSettingBloc, UserSettingState>(
              builder: (context, userSettingState) {
                if (smokingEntryState is SmokingEntryLoading || userSettingState is FetchUserSettingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (smokingEntryState is FetchSmokingEntrySuccess && userSettingState is FetchUserSettingSuccess) {
                  if (userSettingState.settings.isEmpty || smokingEntryState.entries.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            IconData(0xe7c6, fontFamily: 'iconfont'),
                            color: Colors.grey.shade400,
                            size: 64,
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'ยินดีต้อนรับผู้ใช้ใหม่ กรุณาป้อนข้อมูลเบื้องต้นเกี่ยวกับพฤติกรรมการสูบบุหรี่ของคุณเพื่อเริ่มใช้งาน',
                              style: Styles.descriptionSecondary,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 12),
                          FlatButton(
                            child: Text(
                              'กรอกข้อมูลเบื้องต้น',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: ColorPalette.primary,
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => UserFirstSettingScreen())),
                          )
                        ],
                      ),
                    );
                  }
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: <Widget>[
                      _buildOverviewStats(smokingEntryState),
                      _buildNonSmokingTimePassed(smokingEntryState),
                      _buildHealthRegenerationList(smokingEntryState),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
