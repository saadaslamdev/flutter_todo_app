import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/states/player_pref.dart';
import '../states/player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit()
      : super(const PlayerState(notes: [], isDarkMode: false, prefs: null));

  void addNote(String note) {
    final newNotes = List<String>.from(state.notes)..insert(0, note);
    emit(state.copyWith(notes: newNotes));
    state.prefs!.setNotes(state.notes);
  }

  void deleteNote(int index) {
    final newNotes = List<String>.from(state.notes)..removeAt(index);
    emit(state.copyWith(notes: newNotes));
    state.prefs!.setNotes(state.notes);
  }

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
    state.prefs!.setIsDarkMode(state.isDarkMode);
  }

  loadData(PlayerPref prefs) {
    var notes = prefs.getNotes();
    var isDarkMode = prefs.getIsDarkMode();
    emit(state.copyWith(notes: notes, isDarkMode: isDarkMode, prefs: prefs));
  }
}
