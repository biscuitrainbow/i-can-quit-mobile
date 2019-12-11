import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SmokingEntryChart extends StatefulWidget {
  @override
  _SmokingEntryChartState createState() => _SmokingEntryChartState();
}

class _SmokingEntryChartState extends State<SmokingEntryChart> {
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

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 160,
                  child: CalendarCarousel(
                    weekFormat: true,
                    locale: 'th',
                    iconColor: ColorPalette.primary,
                    headerTextStyle: Styles.title,
                    weekdayTextStyle: Styles.title.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    daysTextStyle: Styles.title.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey.shade700),
                    weekendTextStyle: Styles.title.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey.shade700),
                    maxSelectedDate: DateTime.now(),
                    selectedDayButtonColor: Colors.white,
                    onCalendarChanged: (datetime) {
                      setState(() {
                        this._selectedDate = datetime;
                      });
                    },
                  ),
                ),
                Container(
                  child: SfCartesianChart(
                    palette: [
                      ColorPalette.primary,
                      ColorPalette.primaryBackground,
                    ],
                    series: <ChartSeries>[
                      StackedColumnSeries<SmokingEntryTimeSeries, DateTime>(
                        dataSource: smokingDaysCount,
                        yValueMapper: (entry, _) => entry.smokingCount,
                        xValueMapper: (entry, _) => entry.dateTime,
                        enableTooltip: true,
                      ),
                      StackedColumnSeries<SmokingEntryTimeSeries, DateTime>(
                        dataSource: cigarettCountPerDay,
                        yValueMapper: (entry, _) => entry.smokingCount,
                        xValueMapper: (entry, _) => entry.dateTime,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
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
