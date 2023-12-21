import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/downloads/widgets/main_title.dart';
import 'package:netflix_app/presentation/home/widgets/number_card.dart';

class NumberTitleCard extends StatelessWidget {
  final List<String> posterList;
  const NumberTitleCard({
    super.key, required this.posterList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: "Top 10 TV Shows in India Today"),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                posterList.length,
                (index) => NumberCard(
                      index: index,
                      imageUrl: posterList[index],
                    )),
          ),
        ),
      ],
    );
  }
}
