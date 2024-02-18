import 'dart:async';

import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
  static String routName = "SplashPage";
}

class _SplashPageState extends State<SplashPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(
        context,
        LogInPage.routName,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            './assets/images/startBG.png',
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                './assets/images/logo.png',
                fit: BoxFit.fill,
                width: 250,
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
