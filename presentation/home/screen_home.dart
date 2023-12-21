import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/downloads/widgets/main_title_card.dart';
import 'package:netflix_app/presentation/home/widgets/background_card.dart';
import 'package:netflix_app/presentation/home/widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
      },
    );
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, value, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            print(direction);
            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                if(state.isLoading){
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2,),
                  );
                }else if(state.hasError){
                  return const Center(
                    child: Text(
                      'Error while getting dara',
                        style: TextStyle(
                        color: Colors.white
                        ),
                        ),
                      );
                }

              //release past year
                final _releasePastYear = state.pastYearMovieList.map((m) {
              return '$imageAppendUrl${m.posterPath}';
                }).toList();
                _releasePastYear.shuffle();

              //trending  
               
                final _trending = state.trendingMovieList.map((m) {
              return '$imageAppendUrl${m.posterPath}';
                }).toList();
                _trending.shuffle();

                //tense dramas
                final _tenseDramas = state.tenseDramaMovieList.map((m) {
              return '$imageAppendUrl${m.posterPath}';
                }).toList();
              _tenseDramas.shuffle();

                //south indian cinema
                 final _southIndianCinemas = state.southIndianMovieList.map((m) {
              return '$imageAppendUrl${m.posterPath}';
                }).toList();
                _southIndianCinemas.shuffle();

                //top10 tv show

                final _top10TvShow = state.trendingTvList.map((t) {
                  return '$imageAppendUrl${t.posterPath}';
                }).toList();
                _top10TvShow.shuffle();
                print(_top10TvShow.length);

                //listview
                  return ListView(
                    children:  [
                      BackgroundCard(),
                      MainTitleCard(
                        title: "Released in the Past Year",
                        posterList: _releasePastYear,
                      ),
                      kheight,
                      MainTitleCard(
                        title: "Trending Now",
                        posterList: _trending,
                      ),
                      kheight,
                      NumberTitleCard(
                        posterList: _top10TvShow,
                        ),
                      kheight,
                      MainTitleCard(
                        title: "Tense Dramas",
                        posterList: _tenseDramas,
                      ),
                      kheight,
                      MainTitleCard(
                        title: "South Indian Cinema",
                        posterList: _southIndianCinemas,
                      ),
                      kheight,
                    ],
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://cdn.vox-cdn.com/thumbor/SEEvZdiXcs0CS-YbPj2gm6AJ8qc=/0x0:3151x2048/1400x1400/filters:focal(1575x1024:1576x1025)/cdn.vox-cdn.com/uploads/chorus_asset/file/15844974/netflixlogo.0.0.1466448626.png",
                                width: 60,
                                height: 60,
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.cast,
                                color: Colors.white,
                                size: 30,
                              ),
                              kwidth,
                              Container(
                                height: 30,
                                width: 30,
                                color: Colors.blue,
                              ),
                              kwidth
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('TV Shows', style: kHomeTitleText),
                              Text(
                                'Movies',
                                style: kHomeTitleText,
                              ),
                              Text(
                                'Categories',
                                style: kHomeTitleText,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : kheight
            ],
          ),
        );
      },
    ));
  }
}
