import 'dart:convert';
import 'dart:io';

import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final TextEditingController _controllerUSerName =
    TextEditingController.fromValue(
  TextEditingValue(
    text: Constants.userData?['user']['name'] ?? '',
  ),
);
final TextEditingController _controllerEmail = TextEditingController.fromValue(
  TextEditingValue(
    text: Constants.userData?['user']['email'] ?? '',
  ),
);
final TextEditingController _controllerFacebook =
    TextEditingController.fromValue(
  TextEditingValue(
    text: Constants.userData?['user']['facebook'] ?? '',
  ),
);
final TextEditingController _controllerInstagram =
    TextEditingController.fromValue(
  TextEditingValue(
    text: Constants.userData?['user']['instagram'] ?? '',
  ),
);
final TextEditingController _controllerAddress =
    TextEditingController.fromValue(
  TextEditingValue(
    text: Constants.userData?['user']['address'] ?? '',
  ),
);
final TextEditingController _controllerPassword = TextEditingController();
final TextEditingController _controllerPasswordConfirm =
    TextEditingController();

class _ProfilePageState extends State<ProfilePage> {
  XFile? _pickedfile;
  late List<int> imageBytes;
  String? base64String;
  final _picker = ImagePicker();
  Future<void> _pickImage() async {
    _pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedfile != null) {
      setState(() {
        imageBytes = File(_pickedfile!.path).readAsBytesSync();
        base64String = base64Encode(imageBytes);
      });
    }
  }

  //  File? _image;
  // File? _pickedfile;
  // final _picker = ImagePicker();
  // Future _pickImage() async {
  //   _pickedfile = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = _pickedfile;

  //   });
  // }

  int _profileActiveTab = 0;
  final _editProfileForm = GlobalKey<FormState>();
  Future? _editProfileFuture;
  static final List<Object> _profileInformationItems = [
    {
      "title": 'الاسم',
      "icon": 'user-square.svg',
      "controller": _controllerUSerName,
      "obscureText": false,
      'validate': (value) {
        if (_controllerUSerName.text == '') {
          return 'كلمة المرور غير صحيحة';
        }
        return null;
      }
    },
    {
      "title": 'البريد الالكتروني',
      "icon": 'direct-notification.svg',
      "controller": _controllerEmail,
      "obscureText": false,
      'validate': (value) {
        if (_controllerEmail.text != '' &&
            !EmailValidator.validate(_controllerEmail.text)) {
          return 'البريد المدخل غير صحيح';
        }
      }
    },
    {
      "title": 'إنستغرام',
      "icon": 'instagram.svg',
      "controller": _controllerInstagram,
      "obscureText": false,
      'validate': (value) {}
    },
    {
      "title": 'فيسبوك',
      "icon": 'facebook.svg',
      "controller": _controllerFacebook,
      "obscureText": false,
      'validate': (value) {}
    },
    {
      "title": 'العنوان',
      "icon": 'map.svg',
      "controller": _controllerAddress,
      "obscureText": false,
      'validate': (value) {}
    },
    {
      "title": 'كلمة المرور الجديدة',
      "icon": 'key_open_password.svg',
      "controller": _controllerPassword,
      "obscureText": true,
      'validate': (value) {
        if (_controllerPassword.text == '') {
          return 'كلمة المرور غير صحيحة';
        } else if (_controllerPassword.text.length < 8) {
          return 'يرجى ادخال المعلومات بشكل صحيح';
        }
        return null;
      }
    },
    {
      "title": 'تكرار كلمة المرور',
      "icon": 'key_open_password.svg',
      "controller": _controllerPasswordConfirm,
      "obscureText": true,
      'validate': (value) {
        if (_controllerPasswordConfirm.text == '') {
          return 'كلمة المرور غير صحيحة';
        } else if (_controllerPasswordConfirm.text.length < 8) {
          return 'يرجى ادخال المعلومات بشكل صحيح';
        }
        return null;
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Object> _profileAmendment = [
      {
        "title": 'الاسم',
        "subTitle": Constants.userData?['user']['name'] ?? '',
        "icon": 'user-square.svg',
      },
      {
        "title": 'البريد الالكتروني',
        "icon": 'direct-notification.svg',
        "subTitle": Constants.userData?['user']['email'] ?? '',
      },
      {
        "title": 'إنستغرام',
        "subTitle": Constants.userData?['user']['instagram'] ?? '',
        "icon": 'instagram.svg',
      },
      {
        "title": 'فيسبوك',
        "subTitle": Constants.userData?['user']['facebook'] ?? '',
        "icon": 'facebook.svg',
      },
      {
        "title": 'العنوان',
        "subTitle": Constants.userData?['user']['address'] ?? '',
        "icon": 'map.svg',
      },
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            height: 125,
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            decoration: BoxDecoration(
              color: Constants.backgroundColorLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: const GradientBoxBorder(
                gradient: Constants.appGradient,
                width: 0.8,
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: _pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/profile.png',
                      image: Constants.userData?['user']['profile_photo_url'],
                      fit: BoxFit.fill,
                      height: 130,
                      width: 130,
                    ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        Constants.userData?['user']['name'] ?? 'add your name',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Constants.darkModeEnabled
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          gradient: Constants.appGradient,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            Constants.userData?['user']['email'] ??
                                'add your email',
                            style: TextStyle(
                              fontSize: 12,
                              color: Constants.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const Gap(5),
                          Icon(
                            Icons.alternate_email_sharp,
                            size: 15,
                            color: Constants.themeColor,
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: <Widget>[
                          Text(
                            Constants.userData?['user']['phone'] ??
                                'add your phone',
                            style: TextStyle(
                              fontSize: 12,
                              color: Constants.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const Gap(5),
                          Icon(
                            Icons.call_outlined,
                            size: 15,
                            color: Constants.themeColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Gap(20),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: SlideSwitcher(
              containerColor: Constants.darkModeEnabled
                  ? Constants.backgroundColorLight
                  : Constants.backgroundColorLight.withOpacity(0.1),
              slidersGradients: const [Constants.appGradient],
              onSelect: (index) {
                setState(() {
                  _profileActiveTab = index;
                });
              },
              isAllContainerTap: true,
              containerHeight: 40,
              containerWight: 300,
              children: [
                Text(
                  'المعلومات الشخصية',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _profileActiveTab == 1 && Constants.darkModeEnabled
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Text(
                  'تعديل',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _profileActiveTab == 0 && Constants.darkModeEnabled
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          _profileActiveTab == 1
              ? Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Form(
                    key: _editProfileForm,
                    child: Column(
                      children: <Widget>[
                        for (final item in _profileInformationItems)
                          switch (item) {
                            {
                              'title': final String title,
                              'icon': final String icon,
                              'controller': final TextEditingController
                                  controller,
                              'obscureText': final bool obscureText,
                              'validate': final String? Function(String?)?
                                  validate,
                            } =>
                              EditProfileItem(
                                icon: icon,
                                title: title,
                                controller: controller,
                                obscureText: obscureText,
                                validator: validate,
                              ),
                            final v => throw Exception('what is $v'),
                          },
                        const Gap(10),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_editProfileForm.currentState!.validate()) {
                                setState(() {
                                  _editProfileFuture = updateProfile(
                                    context,
                                    Constants.userTokenLocal.read('token'),
                                    _controllerUSerName.text,
                                    _controllerEmail.text,
                                    _controllerAddress.text,
                                    _controllerFacebook.text,
                                    _controllerInstagram.text,
                                    _controllerPassword.text,
                                    _controllerPasswordConfirm.text,
                                    // '',
                                    // '',
                                    true,
                                    base64String ?? '',
                                  ).then(
                                    (value) {
                                      setState(() {
                                        Constants.userTokenLocal
                                            .remove('userLoginData');
                                        _controllerPassword.text = '';
                                        _controllerPasswordConfirm.text = '';
                                        _controllerUSerName.text = Constants
                                                .userData?['user']['name'] ??
                                            '';
                                        _controllerEmail.text = Constants
                                                .userData?['user']['email'] ??
                                            '';
                                        _controllerAddress.text = Constants
                                                .userData?['user']['address'] ??
                                            '';
                                        _controllerFacebook.text =
                                            Constants.userData?['user']
                                                    ['facebook'] ??
                                                '';
                                        _controllerInstagram.text =
                                            Constants.userData?['user']
                                                    ['instagram'] ??
                                                '';
                                      });
                                      showSimpleNotification(
                                        Text(
                                          'تم التعديل',
                                          textAlign: TextAlign.right,
                                        ),
                                        background: Colors.green[600],
                                      );
                                    },
                                  ).catchError((onError) async {
                                    debugPrint(onError.toString());
                                    showSimpleNotification(
                                      Text(
                                        onError.toString(),
                                        textAlign: TextAlign.right,
                                      ),
                                      background: Colors.red[600],
                                    );
                                  });
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.itemColor,
                              shadowColor: Colors.transparent,
                            ),
                            child: FutureBuilder(
                              future: _editProfileFuture,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return const Text('حفظ التعديل');
                                  case ConnectionState.active:
                                    return const Text('none');
                                  case ConnectionState.waiting:
                                    return CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Constants.textColorLight,
                                    );
                                  case ConnectionState.done:
                                    return Text('تم التعديل');

                                  default:
                                    return const Text('defult');
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                    children: <Widget>[
                      for (final item in _profileAmendment)
                        switch (item) {
                          {
                            'title': final String title,
                            'subTitle': final String subTitle,
                            'icon': final String icon,
                          } =>
                            subTitle.isNotEmpty
                                ? ProfileItem(
                                    icon: icon,
                                    subTitle: subTitle,
                                    title: title,
                                  )
                                : const SizedBox(width: 0, height: 0),
                          final v => throw Exception('what is $v'),
                        },
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('Working !!!');
                            confidenceDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'تسجيل الخروج ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> confidenceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'هل أنت متأكد؟',
            textAlign: TextAlign.right,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'هل تريد تسجيل الخروج من حسابك؟',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // EXIT
              child: const Text('نعم'),
              onPressed: () {
                Constants.userTokenLocal.remove('token');
                GoRouter.of(context).pushReplacement(LogInPage.routName);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   LogInPage.routName,
                //   ModalRoute.withName('/'),
                // );
              },
            ),
          ],
        );
      },
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.darkModeEnabled
            ? Constants.backgroundColorLight
            : Constants.backgroundColorLight.withOpacity(0.1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: 150,
            decoration: BoxDecoration(
              color: Constants.darkModeEnabled
                  ? Constants.secondColor
                  : Constants.themeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(5),
                  SvgPicture.asset(
                    'assets/svgs/userDataIcons/${icon}',
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              subTitle,
              style: TextStyle(
                fontSize: 16,
                color: Constants.darkModeEnabled ? Colors.white : Colors.black,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileItem extends StatefulWidget {
  final String title;
  final String icon;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  const EditProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.obscureText,
    required this.validator,
  });

  @override
  State<EditProfileItem> createState() => _EditProfileItemState();
}

class _EditProfileItemState extends State<EditProfileItem> {
  bool showPassword = true;
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.darkModeEnabled
            ? Constants.backgroundColorLight
            : Constants.backgroundColorLight.withOpacity(0.1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: 150,
            decoration: BoxDecoration(
              color: Constants.darkModeEnabled
                  ? Constants.secondColor
                  : Constants.themeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const Gap(5),
                  SvgPicture.asset(
                    'assets/svgs/userDataIcons/${widget.icon}',
                    width: 25,
                    height: 25,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          // Expanded(
          //   child: AutoSizeTextField(
          //     textAlign: TextAlign.right,
          //     controller: controller,
          //     style: TextStyle(
          //       fontSize: 17,
          //       color: Constants.darkModeEnabled ? Colors.white : Colors.black,
          //     ),
          //     maxLines: 1,
          //     decoration: const InputDecoration(
          //       border: InputBorder.none,
          //       isDense: true,
          //       contentPadding: EdgeInsets.all(20),
          //     ),
          //   ),
          // ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: TextFormField(
                validator: widget.validator,
                controller: widget.controller,
                textAlign: TextAlign.center,
                obscureText: widget.obscureText == true
                    ? showPassword
                    : widget.obscureText,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Constants.darkModeEnabled ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: _validate,
                  fillColor: Colors.red[200],
                  errorText: null,
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            !showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                          ),
                          color: Constants.themeColor,
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
