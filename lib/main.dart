import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/StartPages/splash_page.dart';
import 'package:fateih/Route/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Constants.themeColor,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
        fontFamily: 'dijlah',
      ),
      initialRoute: SplashPage.routName,
      routes: routes,
    );
  }
}
