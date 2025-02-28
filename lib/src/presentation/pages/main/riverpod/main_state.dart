import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(false) bool isShopsLoading,
    @Default(false) bool isMoreShopsLoading,
    @Default(true) bool hasMore,
    @Default([]) List<RestaurantData> shops,
    @Default('') String query,
    @Default(0) int selectIndex,
  }) = _MainState;

  const MainState._();
}
