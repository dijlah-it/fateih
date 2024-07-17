import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/login_input.dart';
import 'package:fateih/Constants/start_bg.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  static String routName = "/RegisterPage";
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassWord = TextEditingController();
  final TextEditingController _controllerPassWordCofirmation =
      TextEditingController();
  Future? _signupFuture;
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
              top: 320,
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                width: size.width * 0.7,
                child: Form(
                  key: _signupForm,
                  child: Column(
                    children: <Widget>[
                      //name
                      LoginInput(
                        labelText: 'الاسم',
                        isEmptyTitle: 'يرجى ادخال اسم المستخدم',
                        inputType: TextInputType.text,
                        minLength: 3,
                        controller: _controllerUserName,
                        maxLength: 100,
                        isPassWord: false,
                      ),
                      const Gap(20),
                      // password
                      LoginInput(
                        labelText: 'كلمة المرور',
                        isEmptyTitle: 'كلمة المرور غير صحيحة',
                        inputType: TextInputType.text,
                        minLength: 8,
                        controller: _controllerPassWord,
                        maxLength: 1000,
                        isPassWord: true,
                      ),
                      const Gap(20),
                      // confirm
                      LoginInput(
                        labelText: 'تكرار كلمة المرور',
                        isEmptyTitle: 'تكرار كلمة المرور غير صحيحة',
                        inputType: TextInputType.text,
                        minLength: 8,
                        controller: _controllerPassWordCofirmation,
                        maxLength: 1000,
                        isPassWord: true,
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
                            if (_signupForm.currentState!.validate()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              debugPrint('Working !!!');
                              debugPrint(_countryDialCode);
                              setState(() {
                                _signupFuture = updateProfile(
                                  context,
                                  Constants.userTokenLocal.read('token'),
                                  _controllerUserName.text,
                                  '',
                                  '',
                                  '',
                                  '',
                                  _controllerPassWord.text,
                                  _controllerPassWordCofirmation.text,
                                  false,
                                  '',
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
                          debugPrint(snapshot.data?['errors']['password'][0]);
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    snapshot.data?['message'] ?? '',
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
                              );
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
