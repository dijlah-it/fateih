import 'package:fateih/Pages/HomePages/home.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:fateih/Pages/StartPages/otp_page.dart';
import 'package:fateih/Pages/StartPages/signup_page.dart';
import 'package:fateih/Pages/StartPages/splash_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routName: (context) => const SplashPage(),
  LogInPage.routName: (context) => const LogInPage(),
  OtpPage.routName: (context) => const OtpPage(),
  SignUpPage.routName: (context) => const SignUpPage(),
  HomePage.routName: (context) => const HomePage(),
};
