import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:google_fonts/google_fonts.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class UserSmokingChart extends StatefulWidget {
  @override
  _UserSmokingChartState createState() => _UserSmokingChartState();
}

class _UserSmokingChartState extends State<UserSmokingChart> {
  DateTime _selectedDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
      builder: (context, state) {
        if (state is FetchSmokingEntrySuccess) {
          final smokingDaysCount = state.smokingCountTimeSeries
              .where((timeSerie) =>
                  timeSerie.dateTime.isAfter(this._selectedDate.subtract(Duration(days: 1))) &&
                  timeSerie.dateTime.isBefore(this._selectedDate.add(Duration(days: 6))))
              .toList();

          final cigarettCountPerDay = state.cigarettCountTimeSeries
              .where((timeSerie) =>
                  timeSerie.dateTime.isAfter(this._selectedDate.subtract(Duration(days: 1))) &&
                  timeSerie.dateTime.isBefore(this._selectedDate.add(Duration(days: 6))))
              .toList();

          return Column(
            children: <Widget>[
              Container(
                height: 60,
                child: CalendarCarousel(
                  viewportFraction: 0.5,
                  headerText:
                      '${DateFormat('d MMM').format(this._selectedDate)} - ${DateFormat('d MMM').format(this._selectedDate.add(Duration(days: 6)))}',
                  showHeader: true,
                  weekFormat: true,
                  locale: 'th',
                  iconColor: ColorPalette.primary,
                  headerTextStyle: Styles.headerSection,
                  maxSelectedDate: DateTime.now(),
                  selectedDayButtonColor: Theme.of(context).scaffoldBackgroundColor,
                  onCalendarChanged: (datetime) {
                    setState(() {
                      this._selectedDate = datetime;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  tooltipBehavior: TooltipBehavior(enable: true),
                  palette: [
                    Colors.grey.shade400,
                    Colors.grey.shade700,
                  ],
                  legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      toggleSeriesVisibility: true,
                      textStyle: ChartTextStyle(fontFamily: GoogleFonts.kanit().fontFamily)),
                  enableSideBySideSeriesPlacement: false,
                  series: <ChartSeries>[
                    ColumnSeries<SmokingEntryTimeSeries, DateTime>(
                      name: 'ปริมาณที่สูบ(มวน)',
                      dataSource: cigarettCountPerDay,
                      yValueMapper: (entry, _) => entry.smokingCount,
                      xValueMapper: (entry, _) => entry.dateTime,
                      width: 0.8,
                    ),
                    ColumnSeries<SmokingEntryTimeSeries, DateTime>(
                      name: 'จำนวนครั้งที่สูบ',
                      dataSource: smokingDaysCount,
                      yValueMapper: (entry, _) => entry.smokingCount,
                      xValueMapper: (entry, _) => entry.dateTime,
                      opacity: 0.8,
                      width: 0.6,
                      spacing: 0.4,
                    ),
                  ],
                  primaryXAxis: DateTimeAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    labelStyle: ChartTextStyle(fontFamily: GoogleFonts.kanit().fontFamily),
                    rangePadding: ChartRangePadding.none,
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0.3),
                    labelStyle: ChartTextStyle(fontFamily: GoogleFonts.kanit().fontFamily),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SmokingEntryTimeSeries {
  final DateTime dateTime;
  final int smokingCount;

  SmokingEntryTimeSeries({
    @required this.dateTime,
    @required this.smokingCount,
  });

  @override
  String toString() => 'SmokingEntryTimeSeries dateTime: $dateTime, smokingCount: $smokingCount';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SmokingEntryTimeSeries && o.dateTime == dateTime && o.smokingCount == smokingCount;
  }

  @override
  int get hashCode => dateTime.hashCode ^ smokingCount.hashCode;
}
