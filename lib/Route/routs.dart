import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/home.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:fateih/Pages/StartPages/otp_page.dart';
import 'package:fateih/Pages/StartPages/register_page.dart';
import 'package:fateih/Pages/StartPages/signup_page.dart';
import 'package:fateih/Pages/StartPages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: LogInPage.routName,
      builder: (context, state) => const LogInPage(),
    ),

    // GoRoute(
    //   path: '/OtpPage/:userphone',
    //   builder: (context, state) => OtpPage(
    //     userphone: state.pathParameters['userphone']!,
    //   ),
    // ),
    GoRoute(
      path: OtpPage.routName,
      builder: (context, state) => const OtpPage(),
      // redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: SignUpPage.routName,
      builder: (context, state) => const SignUpPage(),
      // redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: RegisterPage.routName,
      builder: (context, state) => const RegisterPage(),
      // redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: HomePage.routName,
      builder: (context, state) => const HomePage(),
      redirect: (context, state) => _redirect(context),
    ),
  ],
);
String? _redirect(BuildContext context) {
  return Constants.userTokenLocal.hasData('token') ? null : LogInPage.routName;
}
