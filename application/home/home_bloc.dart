import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    /*
    on event get homescreen data
     */
    on<HomeEvent>((event, emit) async {

      log('GETTING HOME SCREEN DATA');
      //send loading to ui

      emit(state.copyWith(isLoading: true, hasError: false));

      //get data

      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      //transform data
     final _state1 = _movieResult.fold((MainFailure failure) {
           return  HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
            );
           },

       (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;

        pastYear!.shuffle();
        trending!.shuffle();
        dramas!.shuffle();
        southIndian!.shuffle();

       return HomeState(
        stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear ,
            trendingMovieList: trending,
            tenseDramaMovieList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false,
            );
      });

    emit(_state1);

    final _state2 =  _tvResult.fold(
          (MainFailure failure) {
            return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
            );
          }, 
          (HotAndNewResp resp) {
            final top10List = resp.results;
             return  HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),  
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramaMovieList: state.tenseDramaMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10List!,
            isLoading: false,
            hasError: false,
            );

          });

      //send to ui
      emit(_state2);
    });
  }
}
