part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required List<HotAndNewData> comingSoonList,
    required List<HotAndNewData> everyOnIsWatchingList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HotAndNewState.initial()=>const HotAndNewState(
    comingSoonList: [],
    everyOnIsWatchingList: [], 
    isLoading: false, 
    hasError: false);
}
