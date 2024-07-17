import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/start_bg.dart';
import 'package:fateih/Constants/unicorn_outline_button.dart';
import 'package:fateih/Pages/StartPages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
  static String routName = "/OtpPage";
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // BG
              StartBG(size: size),
              const Positioned(
                top: 330,
                child: Text(
                  'رمز التحقق من رقم الهاتف',
                  style: TextStyle(
                    color: Constants.themeColor,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
              Positioned(
                top: 400,
                child: SizedBox(
                  width: size.width,
                  child: FractionallySizedBox(
                    child: PinputExample(
                      phone: Constants.userPhoneNumber,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinputExample extends StatefulWidget {
  const PinputExample({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;
  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  Future? _otpFuture;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 47,
      height: 47,
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Constants.userData?['otp']['otp'].toString() ?? 'ادخل الرمز',
            style: TextStyle(color: Colors.white.withAlpha(100)),
          ),
          const Gap(10),
          Pinput(
            controller: pinController,
            focusNode: focusNode,
            length: 6,
            androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => const SizedBox(width: 8),
            validator: (value) {
              return value?.length == 6
                  ? checkOTP(
                      Constants.userData!['otp']['user_id'].toString(),
                      pinController.text,
                    )
                  : '';
            },
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              debugPrint('onCompleted: $pin');
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
          const Gap(30),
          Text(
            ' ارسال لك رمز تاكيد على رقم الهاتف : \n ${widget.phone}',
            style: const TextStyle(
              color: Colors.white70,
              height: 2,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          FutureBuilder(
            future: _otpFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                          children: <Widget>[
                            Text(
                              snapshot.data['errors'][0],
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
                      : SizedBox();
                default:
                  return const Text('');
              }
            },
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UnicornOutlineButton(
                strokeWidth: 1,
                radius: 24,
                gradient: Constants.appGradient,
                child: const Text(
                  'تعديل الرقم',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.go(SignUpPage.routName);
                },
              ),
              const Gap(10),
              Container(
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: Constants.appGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () {
                    // if (formKey.currentState!.validate()) {
                    //   checkOTP(Constants.userData!['otp']['user_id'].toString(),
                    //       Constants.userData!['otp']['otp'].toString());
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(
                    'تاكيد',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  checkOTP(String userId, String otp) {
    debugPrint('=============================');
    debugPrint(userId);
    debugPrint(otp);
    debugPrint('=============================');

    FocusManager.instance.primaryFocus?.unfocus();
    _otpFuture = getUserToken(
      context,
      'checkotp',
      userId,
      otp,
    );
  }
}
