import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            actions: [
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
            bottom: TabBar(
                labelColor: kBlackColor,
                unselectedLabelColor: kWhiteColor,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    text: "🍿 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's watching",
                  )
                ]),
          ),
        ),
        body:const TabBarView(children: [
           ComingSoonList(
            key: Key('coming soon'),
          ),
          EveryonesIsWatchingList(key: Key('everyone_is_watching'),)
        ]),
      ),
    );
  }

 
}

  class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const loadDataInComingSoon());
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
         BlocProvider.of<HotAndNewBloc>(context)
            .add(const loadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('Coming soon list is empty'),
            );
          } else {
            return ListView.builder(
              
              itemCount: state.comingSoonList.length,
              padding: EdgeInsets.only(top: 20),
              itemBuilder: (BuildContext context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null || movie.releaseDate == null) {
                  return const SizedBox();
                }
                log(movie.releaseDate.toString());
                String month = '';
                String date = '';
                //  try{
                // final _date = DateTime.tryParse(movie.releaseDate!);
                // if(_date != null){
                //  final formatedDate = DateFormat.yMMMMd('en_us').format(_date);
                //  //log(formatedDate.toString());
                //  month =  formatedDate.split('').first.substring(0,3).toUpperCase();
                //  date = movie.releaseDate!.split('-')[1];
                //  }else{
                //   month ='';
                //   date = '';
                //  }
                //  }catch(_){
                //   month ='';
                //   date = '';
                //  }
    
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  if (_date != null) {
                    final formattedDate = DateFormat('MMM dd').format(_date);
                    month = formattedDate.split(' ')[0].toUpperCase();
                    date = formattedDate.split(' ')[1];
                  } else {
                    // Handle the case when _date is null after parsing
                    log('Failed to parse date for movie with ID: ${movie.id}');
                    month = '';
                    date = '';
                  }
                } catch (e, stackTrace) {
                  // Handle any additional error if needed
                  log('Error parsing date for movie with ID: ${movie.id}\nError: $e\n$stackTrace');
                  month = '';
                  date = '';
                }
    
                return ComingSoonWidget(
                
                    id: movie.id.toString(),
                    month: month,
                    day: date,
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No description');
              },
            );
          }
        },
      ),
    );
  }
}


  class EveryonesIsWatchingList extends StatelessWidget {
  const EveryonesIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const loadDataInEveryoneIsWatching());
      },
    );
    return RefreshIndicator(
       onRefresh: () async {
         BlocProvider.of<HotAndNewBloc>(context)
            .add(const loadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon'),
            );
          } else if (state.everyOnIsWatchingList.isEmpty) {
            return const Center(
              child: Text('Coming soon list is empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.everyOnIsWatchingList.length,
              itemBuilder: (BuildContext context, index) {
                final movie = state.everyOnIsWatchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
               
                //  try{
                // final _date = DateTime.tryParse(movie.releaseDate!);
                // if(_date != null){
                //  final formatedDate = DateFormat.yMMMMd('en_us').format(_date);
                //  //log(formatedDate.toString());
                //  month =  formatedDate.split('').first.substring(0,3).toUpperCase();
                //  date = movie.releaseDate!.split('-')[1];
                //  }else{
                //   month ='';
                //   date = '';
                //  }
                //  }catch(_){
                //   month ='';
                //   date = '';
                //  }
    
               
    
                final tv = state.everyOnIsWatchingList[index];
    
                return EveryonesWatchingWidget(
                  posterPath:'$imageAppendUrl${tv.posterPath}',
                   movieName: tv.originalName??'No name provided', 
                   description: tv.overview??'No description',
                   );
              }
            );
          }
        },
      ),
    );
  }
}
