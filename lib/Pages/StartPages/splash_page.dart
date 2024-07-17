import 'dart:async';

import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/home.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:delayed_widget/delayed_widget.dart';

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
      debugPrint(Constants.userTokenLocal.read('token'));

      if (Constants.userTokenLocal.read('token') == null) {
        GoRouter.of(context).pushReplacement(LogInPage.routName);
      } else {
        homeAPI(Constants.userTokenLocal.read('token')).then(
          (value) {
            GoRouter.of(context).pushReplacement(HomePage.routName);
          },
        );
      }
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
            child: DelayedWidget(
              animationDuration: Duration(seconds: 2),
              // animation: DelayedAnimations.SLIDE_FROM_TOP,
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
