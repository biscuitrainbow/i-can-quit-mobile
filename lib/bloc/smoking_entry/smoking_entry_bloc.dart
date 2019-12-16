import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/user_setting_repository.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/user_smoking_chart.dart';
import 'package:kt_dart/kt.dart';
import 'package:intl/intl.dart';

class SmokingEntryBloc extends Bloc<SmokingEntryEvent, SmokingEntryState> {
  final SmokingEntryRepository _smokingEntryRepository;
  final UserSettingRepository _userSettingRepository;

  SmokingEntryBloc(this._smokingEntryRepository, this._userSettingRepository);
  @override
  SmokingEntryState get initialState => SmokingEntryLoading();

  @override
  Stream<SmokingEntryState> mapEventToState(SmokingEntryEvent event) async* {
    if (event is FetchSmokingEntry) {
      yield SmokingEntryLoading();

      try {
        final entries = await _smokingEntryRepository.fetchEntries();
        final latestHasSmokedEntry = entries.isNotEmpty ? entries.firstWhere((entry) => entry.hasSmoked) : null;

        final dateGroupedEntries = KtList.from(entries).groupBy((entry) => DateFormat('yyyy-MM-dd').format(entry.datetime));
        final nonSmokedDates = dateGroupedEntries.filter((date) {
          return date.value.filter((entry) => entry.hasSmoked).count() == 0;
        });

        final smokingCountTimeSeries = dateGroupedEntries.map((date) {
          return SmokingEntryTimeSeries(
            dateTime: DateFormat('yyyy-MM-dd').parse(date.key),
            smokingCount: date.value.filter((SmokingEntry entry) => entry.hasSmoked).count(),
          );
        });

        final cigaretteCountTimeSeries = dateGroupedEntries.map((date) {
          return SmokingEntryTimeSeries(
              dateTime: DateFormat('yyyy-MM-dd').parse(date.key),
              smokingCount: date.value.asList().fold(0, (int acc, SmokingEntry entry) {
                return acc + entry.numberOfCigarettes;
              }));
        });

        final settings = await _userSettingRepository.fetchUserSettings();
        final latestSetting = settings.isNotEmpty ? settings.last : null;

        yield FetchSmokingEntrySuccess(
          entries: entries,
          latestHasSmokedEntry: latestHasSmokedEntry,
          nonSmokingDays: nonSmokedDates.count(),
          smokingCountTimeSeries: smokingCountTimeSeries.asList(),
          cigarettCountTimeSeries: cigaretteCountTimeSeries.asList(),
          userSettings: settings,
          latestUserSetting: latestSetting,
        );
      } catch (error) {
        print(error);
      }
    }

    if (event is SaveSmokingEntry) {
      yield SaveSmokingEntryLoading();

      try {
        await _smokingEntryRepository.create(event.entry);

        yield SaveSmokingEntrySuccess();

        this.add(FetchSmokingEntry());
      } catch (error) {
        yield SaveSmokingEntryError();
      }
    }
  }
}
