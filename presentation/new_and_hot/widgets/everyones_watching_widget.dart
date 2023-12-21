import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_app/presentation/pres_widgets/video_widgets.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget({
    super.key, 
    required this.posterPath, 
    required this.movieName, 
    required this.description});
 

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight,
        Text(
          movieName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        kheight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: kGreyColor, fontWeight: FontWeight.bold),
        ),
        kheight50,
        VideoWidget(url:posterPath,),
        kheight20,
      const  Row ( 
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomeButtonWidget(
              icon: Icons.share,
              title: 'Share',
              iconSize: 25,
              textSize: 12,
            ),
            kwidth,
            CustomeButtonWidget(
              icon: Icons.add,
              title: 'MY List',
              iconSize: 25,
              textSize: 12,
            ),
            kwidth,
            CustomeButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              iconSize: 25,
              textSize: 12,
            ),
            kwidth,
          ],
        )
      ],
    );
  }
}
