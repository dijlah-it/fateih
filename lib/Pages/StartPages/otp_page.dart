import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/home.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:awesome_snackbar_content_new/awesome_snackbar_content.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
  static String routName = "OtpPage";
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              // BG
              StartBG(size: size),
              Positioned(
                right: 30,
                top: 350,
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
                    child: PinputExample(),
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
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

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
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'رمز التحقق غير صحيح';
              },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
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
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          const Gap(30),
          Text(
            ' ارسال لك رمز تاكيد على رقم الهاتف :\n 964777777777+',
            style: TextStyle(
              color: Colors.white70,
              height: 2,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UnicornOutlineButton(
                strokeWidth: 1,
                radius: 24,
                gradient: Constants.appGradient,
                child: Text(
                  'تعديل الرقم',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  focusNode.unfocus();
                  formKey.currentState!.validate();
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
                    debugPrint('Working !!!');
                    Navigator.popAndPushNamed(
                      context,
                      HomePage.routName,
                    );

                    final snackBar = SnackBar(
                      elevation: 0,
                      // behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: AwesomeSnackbarContent(
                          title: 'اهلا بك',
                          message: 'اهلا بك يا محمد',
                          contentType: ContentType.success,
                        ),
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text(
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
}
