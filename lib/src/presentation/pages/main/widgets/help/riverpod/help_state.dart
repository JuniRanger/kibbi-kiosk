
import 'package:kiosk/src/models/data/help_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'help_state.freezed.dart';

@freezed
class HelpState with _$HelpState {

  const factory HelpState({
    @Default(false) bool isLoading,
    @Default(null) HelpModel? data

  }) = _HelpState;

  const HelpState._();
}