import 'package:flutter/material.dart';

class StartBG extends StatelessWidget {
  const StartBG({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          './assets/images/startBG.png',
          fit: BoxFit.fill,
          width: size.width,
          height: size.height,
        ),
        //Pattern
        Positioned(
          top: 0,
          child: Image.asset(
            './assets/images/pattern.png',
            fit: BoxFit.fill,
            width: size.width,
            height: 340,
          ),
        ),
        // LOGO
        Positioned(
          top: 150,
          child: Image.asset(
            './assets/images/logo.png',
            fit: BoxFit.fill,
            width: 150,
            height: 150,
          ),
        ),
      ],
    );
  }
}