import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/local_auth_service.dart';
import 'package:fateih/Constants/login_input.dart';
import 'package:fateih/Constants/start_bg.dart';
import 'package:fateih/Pages/StartPages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
  static String routName = "/SignInPage";
}

class _LogInPageState extends State<LogInPage> {
  Future? _loginFuture;
  final _loginForm = GlobalKey<FormState>();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerPassWord = TextEditingController();
  late Map<dynamic, dynamic> userLoginData;
  @override
  void initState() {
    super.initState();
    userLoginData = Constants.userTokenLocal.read('userLoginData') ?? {};
    // debugPrint('----------->' + userLoginData.toString());
  }

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
                top: 330,
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _loginForm,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: Column(
                            children: <Widget>[
                              LoginInput(
                                controller: _controllerPhoneNumber,
                                labelText: 'رقم الجوال',
                                isEmptyTitle: 'أدخل رقم هاتفك المحمول',
                                inputType: TextInputType.number,
                                minLength: 11,
                                maxLength: 11,
                                isPassWord: false,
                              ),
                              const Gap(15),
                              LoginInput(
                                controller: _controllerPassWord,
                                labelText: 'كلمة المرور',
                                isEmptyTitle: 'كلمة المرور غير صحيحة',
                                inputType: TextInputType.text,
                                minLength: 8,
                                maxLength: 100000,
                                isPassWord: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                            gradient: Constants.appGradient,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_loginForm.currentState!.validate()) {
                              debugPrint('Working !!!');
                              setState(() {
                                _loginFuture = signin(
                                  context,
                                  _controllerPhoneNumber.text,
                                  _controllerPassWord.text,
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // authenticate
                      userLoginData['phoneNumber'] != null && kIsWeb == false
                          ? Container(
                              height: 44.0,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Constants.themeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final authenticate =
                                      await LocalAuth.authenticate();
                                  setState(() {
                                    debugPrint('------====' +
                                        userLoginData['phoneNumber']);
                                    debugPrint('------====' +
                                        userLoginData['passWord']);
                                    if (authenticate) {
                                      _loginFuture = signin(
                                        context,
                                        userLoginData['phoneNumber'],
                                        userLoginData['passWord'],
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: const Text(
                                  'الدخول ببصمة اليد أو الوجه',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      const Gap(10),
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
                              GoRouter.of(context).push(SignUpPage.routName);
                              // GoRouter.of(context).pushReplacement(SignUpPage.routName);
                              // GoRouter.of(context).pushNamed();
                              // Navigator.pushNamed(
                              //   context,
                              //   SignUpPage.routName,
                              // );
                            },
                            child: Text(
                              'تسجيل',
                              style: TextStyle(
                                color: Constants.themeColor,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // context.go(SignUpPage.routName);
                          GoRouter.of(context).push(SignUpPage.routName);
                          // GoRouter.of(context).go(SignUpPage.routName);
                          // GoRouter.of(context).pushNamed(SignUpPage.routName);
                          // Navigator.pushNamed(
                          //   context,
                          //   SignUpPage.routName,
                          // );
                        },
                        child: Text(
                          'نسيت كلمة المرور',
                          style: TextStyle(
                            color: Constants.themeColor,
                            fontSize: 12,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const Gap(20),
                      FutureBuilder(
                        future: _loginFuture,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          debugPrint(snapshot.data.toString());
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              return snapshot.data?['message'] != null
                                  ? Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data['message'] ?? 'eee',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Gap(5),
                                        const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        )
                                      ],
                                    )
                                  : const Text('weqwqwe');
                            default:
                              return const Text('defult');
                          }
                        },
                      ),
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
