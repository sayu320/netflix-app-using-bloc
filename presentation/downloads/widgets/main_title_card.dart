import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/downloads/widgets/main_title.dart';

import '../../pres_widgets/main_card.dart';

class MainTitleCard extends StatelessWidget {
  final String title;
  final List<String> posterList;
  const MainTitleCard({
    super.key,
    required this.title, required this.posterList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(posterList.length,
             (index) => MainCard(imageUrl: posterList[index],
             )
             ),
          ),
        ),
      ],
    );
  }
}
