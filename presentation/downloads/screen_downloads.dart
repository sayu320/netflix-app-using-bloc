import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/pres_widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads  ({super.key});

  final  _widgetList =  [const _SmartDownloads(), Section2(), const Section3()];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(
              title: 'Downloads',
            )),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            itemCount: _widgetList.length));
  }
}

class Section2 extends StatelessWidget {
 const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final Size size = MediaQuery.of(context).size;

    return Column(children: [
      const Text(
        "Introducing Downloads for you",
        maxLines: 1,
        textAlign: TextAlign.center,
        softWrap: false,
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
      ),
      kheight,
     const Text (
        "We'll download a personalized selection of\nmovies and shows for you,so there's\nalways something to watch on your\ndevice",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      kheight,
      BlocBuilder<DownloadsBloc, DownloadsState>(builder: (context, state) {
        if (state.downloads != null && state.downloads!.length >= 3) {
          return SizedBox(
            width: size.width,
            height: size.width,
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.37,
                        backgroundColor: Colors.grey[800],
                      ),
                      DownloadsImageWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads![0].posterPath}',
                        angle: 20,
                        margin: const EdgeInsets.only(left: 160, bottom: 40),
                        size: Size(size.width * 0.35, size.width * 0.55),
                      ),
                      DownloadsImageWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads![1].posterPath}',
                        angle: -20,
                        margin: const EdgeInsets.only(right: 160, bottom: 40),
                        size: Size(size.width * 0.35, size.width * 0.55),
                      ),
                      DownloadsImageWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads![2].posterPath}',
                        angle: 0,
                        margin: const EdgeInsets.only(top: 0),
                        size: Size(
                          size.width * 0.38,
                          size.width * 0.6,
                        ),
                        radius: 5,
                      ),
                    ],
                  ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    ]);
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set Up",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kheight,
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See What You Can Download",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        kwidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kwidth,
        Text("Smart Downloads"),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {super.key,
      required this.imageList,
      required this.angle,
      required this.margin,
      required this.size,
      this.radius = 10});

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Padding(
        padding: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageList,
                    ))),
          ),
        ),
      ),
    );
  }
}
