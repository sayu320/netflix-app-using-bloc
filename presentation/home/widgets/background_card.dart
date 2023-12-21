import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {


  const BackgroundCard( {super.key, });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image:NetworkImage('https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p12690929_p_v8_ab.jpg') ,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomeButtonWidget(
                  icon: Icons.add,
                  title: 'My List',
                ),
                _PlayButton(),
                CustomeButtonWidget(icon: Icons.info, title: 'info')
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(kWhiteColor),
          padding:
              MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8))),
      icon: const Icon(
        Icons.play_arrow,
        color: kBlackColor,
        size: 40,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Play',
          style: TextStyle(
              color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
