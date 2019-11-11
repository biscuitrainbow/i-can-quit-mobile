import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:g2x_week_calendar/g2x_simple_week_calendar.dart';

class SmokingEntryChart extends StatefulWidget {
  @override
  _SmokingEntryChartState createState() => _SmokingEntryChartState();
}

class _SmokingEntryChartState extends State<SmokingEntryChart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
      builder: (context, state) {
        if (state is FetchSmokingEntrySuccess) {
          final data = state.entries
              .where((entry) => entry.datetime.month == 8)
              .map((entry) => TimeSeriesSmokingEntry(
                    dateTime: entry.datetime,
                    smokingCount: 20,
                  ))
              .toList();

          final series = [
            charts.Series<TimeSeriesSmokingEntry, DateTime>(
              id: 'Sales',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (TimeSeriesSmokingEntry sales, _) => sales.dateTime,
              measureFn: (TimeSeriesSmokingEntry sales, _) => sales.smokingCount,
              data: data,
            )
          ];

          return Column(
            children: <Widget>[
              G2xSimpleWeekCalendar(DateTime.now(), dateCallback: (date) {
                print(date);
              }),
              Expanded(
                child: charts.TimeSeriesChart(
                  series,
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                ),
              )
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TimeSeriesSmokingEntry {
  final DateTime dateTime;
  final int smokingCount;

  TimeSeriesSmokingEntry({
    @required this.dateTime,
    @required this.smokingCount,
  });
}
