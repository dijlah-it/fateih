import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';

class SpacerLine extends StatelessWidget {
  const SpacerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        const RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: Icon(
            Icons.square,
            color: Constants.themeColor,
            size: 6,
          ),
        ),
        Container(
          height: 1,
          width: 18,
          decoration: const BoxDecoration(
            gradient: Constants.appGradient,
          ),
        ),
        const RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: Icon(
            Icons.square,
            color: Constants.itemColor,
            size: 6,
          ),
        ),
      ],
    );
  }
}
