import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_app/presentation/pres_widgets/video_widgets.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget(
      {super.key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterPath,
      required this.movieName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
         SizedBox(
          width: 50,
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  day,
                  style:const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 400,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(url: posterPath,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        movieName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                 const Spacer(),
                const  Row  (
                    children:  [
                      CustomeButtonWidget(
                        icon: Icons.notifications,
                        title: 'Remind Me',
                        iconSize: 12,
                        textSize: 12,
                      ),
                      kwidth,
                      CustomeButtonWidget(
                        icon: Icons.info,
                        title: 'Info',
                        iconSize: 12,
                        textSize: 12,
                      ),
                      kwidth
                    ],
                  )
                ],
              ),
              kheight,
              Text(
                "Coming on $day $month",
                 maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                style:
                   const TextStyle(fontWeight: FontWeight.bold, color: kGreyColor),
              ),
              kheight,
              Text(
                movieName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  description,
                  maxLines: 4,
                  overflow: TextOverflow.clip,
                  style:
                    const  TextStyle(color: kGreyColor, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
