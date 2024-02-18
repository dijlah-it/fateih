import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/StartPages/otp_page.dart';
import 'package:fateih/Pages/StartPages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
  static String routName = "LogInPage";
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // BG
              StartBG(size: size),
              //INPUTS
              Positioned(
                top: 350,
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    children: <Widget>[
                      LoginInput(
                        labelText: 'رقم الهاتف',
                        inputType: TextInputType.number,
                      ),
                      const Gap(30),
                      Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                            gradient: Constants.appGradient,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              OtpPage.routName,
                            );
                            debugPrint('Working !!!');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Gap(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            'ليس لديك حساب ؟ ',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SignUpPage.routName,
                              );
                            },
                            child: Text(
                              '  تسجيل..',
                              style: TextStyle(
                                color: Constants.themeColor,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
