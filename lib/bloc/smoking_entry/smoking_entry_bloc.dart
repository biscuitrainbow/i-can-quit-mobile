import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';

class SmokingEntryBloc extends Bloc<SmokingEntryEvent, SmokingEntryState> {
  final SmokingEntryRepository _smokingEntryRepository;

  SmokingEntryBloc(this._smokingEntryRepository);
  @override
  SmokingEntryState get initialState => SmokingEntryLoading();

  @override
  Stream<SmokingEntryState> mapEventToState(SmokingEntryEvent event) async* {
    if (event is FetchSmokingEntry) {
      yield SmokingEntryLoading();

      try {
        final entries = await _smokingEntryRepository.fetchEntries();
        // final latestHasSmokedEntry = entries.firstWhere((entry) => entry.hasSmoked);
        final nonSmokingDays = entries.where((entry) => !entry.hasSmoked).toList().length;

        yield FetchSmokingEntrySuccess(
          entries: entries,
          // latestHasSmokedEntry: latestHasSmokedEntry,
          nonSmokingDays: nonSmokingDays,
        );
      } catch (error) {
        print(error);
      }
    }

    if (event is SaveSmokingEntry) {
      try {
        await _smokingEntryRepository.create(event.entry);

        yield SaveSmokingEntrySuccess();
      } catch (error) {
        print(error);
      }
    }
  }
}
