import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatefulWidget {
  final Function callback;
  const SettingPage({
    super.key,
    required this.callback,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool _allowNotif;
  GetStorage _setSetting = GetStorage();
  @override
  void initState() {
    super.initState();
    _allowNotif = _setSetting.read('allowNotif') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: <Widget>[
          // NOTIF
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Icon(
                  Icons.notifications_active_outlined,
                  color: Constants.darkModeEnabled
                      ? Colors.white54
                      : Colors.black54,
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    'إشعارات',
                    style: TextStyle(
                      color: Constants.darkModeEnabled
                          ? Colors.white54
                          : Colors.black54,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Switch(
                  activeColor: Constants.themeColor,
                  value: _allowNotif,
                  onChanged: (value) {
                    setState(() {
                      _allowNotif = value;
                    });
                    _setSetting.write('allowNotif', _allowNotif);
                  },
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: const Divider(
              color: Color.fromARGB(31, 115, 115, 115),
            ),
          ),
          // THEME
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Icon(
                  Constants.darkModeEnabled
                      ? Icons.dark_mode_outlined
                      : Icons.sunny,
                  color: Constants.darkModeEnabled
                      ? Colors.white54
                      : Colors.black54,
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    Constants.darkModeEnabled ? 'داکن' : 'فاتح',
                    style: TextStyle(
                      color: Constants.darkModeEnabled
                          ? Colors.white54
                          : Colors.black54,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Switch(
                  activeColor: Constants.themeColor,
                  value: Constants.darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      widget.callback(8);
                      Constants.darkModeEnabled = value;
                      _setSetting.write('themeMode', value);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: const Divider(
              color: Color.fromARGB(31, 115, 115, 115),
            ),
          ),
          // SHARE APP
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: InkWell(
              onTap: () {
                final box = context.findRenderObject() as RenderBox?;
                Share.share(
                  "أدعوك للاطلاع على تطبيق (${Constants.packageInfo.appName}) وذلك عبر الرابط التالي: \n https://play.google.com/store/apps/details?id=${Constants.packageInfo.packageName}",
                  subject: "المشاركة ضمن:",
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(
                      Icons.share_outlined,
                      color: Constants.darkModeEnabled
                          ? Colors.white54
                          : Colors.black54,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        'مشاركة التطبيق',
                        style: TextStyle(
                          color: Constants.darkModeEnabled
                              ? Colors.white54
                              : Colors.black54,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Icon(
                      Icons.chevron_left,
                      color: Constants.darkModeEnabled
                          ? Colors.white54
                          : Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
