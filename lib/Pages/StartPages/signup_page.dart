import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
  static String routName = "SignUpPage";
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            StartBG(size: size),
            Positioned(
              top: 350,
              child: SizedBox(
                width: size.width * 0.7,
                child: Column(
                  children: <Widget>[
                    LoginInput(
                      labelText: 'الاسم',
                      inputType: TextInputType.text,
                    ),
                    const Gap(30),
                    IntlPhoneField(
                      dropdownIconPosition: IconPosition.trailing,
                      invalidNumberMessage: 'رقم الجوال غير صالح',
                      searchText: 'البحث عن البلد',
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      dropdownTextStyle: TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        labelText: 'رقم الجوال',
                        labelStyle: const TextStyle(
                          color: Constants.themeColor,
                        ),
                        border: const GradientOutlineInputBorder(
                          gradient: Constants.appGradient,
                          width: 1,
                        ),
                      ),
                      initialCountryCode: 'IQ',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    const Gap(40),
                    Container(
                      height: 44.0,
                      decoration: BoxDecoration(
                          gradient: Constants.appGradient,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          'تاكيد رقم الهاتف...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
