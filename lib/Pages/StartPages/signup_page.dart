import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/login_input.dart';
import 'package:fateih/Constants/start_bg.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
  static String routName = "/SignUpPage";
}

class _SignUpPageState extends State<SignUpPage> {
  Future? _signupFuture;
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final _signupForm = GlobalKey<FormState>();
  String _countryDialCode = '964';
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
              top: 330,
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                width: size.width * 0.7,
                child: Form(
                  key: _signupForm,
                  child: Column(
                    children: <Widget>[
                      //country code
                      // IntlPhoneField(
                      //   controller: _controllerPhoneNumber,
                      //   dropdownIconPosition: IconPosition.trailing,
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'أدخل رقم هاتفك المحمول بشكل صحيح';
                      //     }
                      //     return null;
                      //   },
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly
                      //   ],
                      //   invalidNumberMessage: 'رقم الجوال غير صالح',
                      //   onCountryChanged: (country) {
                      //     setState(() {
                      //       _countryDialCode = country.dialCode;
                      //     });
                      //   },
                      //   dropdownIcon: const Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.white70,
                      //   ),
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //   ),
                      //   dropdownTextStyle:
                      //       const TextStyle(color: Colors.white70),
                      //   decoration: const InputDecoration(
                      //     labelText: 'رقم الجوال',
                      //     labelStyle: TextStyle(
                      //       color: Constants.themeColor,
                      //     ),
                      //     border: GradientOutlineInputBorder(
                      //       gradient: Constants.appGradient,
                      //       width: 1,
                      //     ),
                      //   ),
                      //   initialCountryCode: 'IQ',
                      // ),
                      LoginInput(
                        controller: _controllerPhoneNumber,
                        labelText: 'رقم الجوال',
                        isEmptyTitle: 'أدخل رقم هاتفك المحمول',
                        inputType: TextInputType.number,
                        minLength: 11,
                        maxLength: 11,
                        isPassWord: false,
                      ),
                      const Gap(20),

                      //submit
                      Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                            gradient: Constants.appGradient,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint(_controllerPhoneNumber.text);
                            if (_signupForm.currentState!.validate()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              debugPrint('Working !!!');
                              debugPrint(_countryDialCode);
                              
                              setState(() {
                                _signupFuture = signup(
                                  context,
                                  _controllerPhoneNumber.text,
                                  _countryDialCode,
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: const Text(
                            'تسجيل',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      const Gap(20),
                      FutureBuilder(
                        future: _signupFuture,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          debugPrint(snapshot.data?['errors'][0]);
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              return snapshot.data?['errors'][0] != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data?['errors'][0],
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Gap(5),
                                        const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 18,
                                        )
                                      ],
                                    )
                                  : SizedBox();
                            default:
                              return const Text('defult');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 10,
                  top: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withAlpha(100),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      LogInPage.routName,
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
