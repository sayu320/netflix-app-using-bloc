import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';

class NumberCard extends StatelessWidget {
  final String imageUrl;
  final int index;
  const NumberCard({super.key, required this.index, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: kRadius20,
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                         imageUrl
                         )
                         )
                         ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 10,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 150,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
