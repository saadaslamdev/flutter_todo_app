import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/states/player_pref.dart';
part 'player_state.freezed.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    required List<String> notes,
    required bool isDarkMode,
    required PlayerPref? prefs,
  }) = _PlayerState;
}