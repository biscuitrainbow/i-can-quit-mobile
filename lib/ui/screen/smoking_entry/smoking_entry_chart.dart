import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendaWrCarousel;
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';

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
          final timeSeries = state.timeSeries
              .where((timeSerie) =>
                  timeSerie.dateTime.isAfter(this._selectedDate.subtract(Duration(days: 1))) &&
                  timeSerie.dateTime.isBefore(this._selectedDate.add(Duration(days: 6))))
              .toList();

          final series = [
            charts.Series<SmokingEntryTimeSeries, DateTime>(
              id: 'Sales',
              colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
              domainFn: (SmokingEntryTimeSeries sales, _) => sales.dateTime,
              measureFn: (SmokingEntryTimeSeries sales, _) => sales.smokingCount,
              data: timeSeries,
            )
          ];

          return Column(
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
              Expanded(
                child: charts.TimeSeriesChart(
                  series,
                  animate: true,
                  defaultRenderer: charts.BarRendererConfig<DateTime>(),
                  domainAxis: charts.DateTimeAxisSpec(
                    tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      day: charts.TimeFormatterSpec(format: 'd', transitionFormat: 'd'),
                    ),
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
