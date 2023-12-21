import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    /*
 get hot and new movie data
 */

    on<loadDataInComingSoon>((event, emit) async {
      //send loading to ui
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOnIsWatchingList: [],
          isLoading: true,
          hasError: false));

      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state

      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOnIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: resp.results!,
            everyOnIsWatchingList: state.everyOnIsWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });

/*
get hot and new tv data
 */

    on<loadDataInEveryoneIsWatching>((event, emit) async {
      //send loading to ui
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOnIsWatchingList: [],
          isLoading: true,
          hasError: false));

      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewTvData();

      //data to state

      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOnIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyOnIsWatchingList: resp.results!,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
