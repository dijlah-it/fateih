import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Route/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fateih/Api/firebase_api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  GetStorage _getAllowNotif = GetStorage();
  Constants.darkModeEnabled = _getAllowNotif.read('themeMode') ?? true;
  if (!kIsWeb) {
    debugPrint('statement');
    await Firebase.initializeApp();
    _getAllowNotif.read('allowNotif') == true
        ? await FirebaseMessaging.instance.subscribeToTopic('general')
        : await FirebaseMessaging.instance.unsubscribeFromTopic('general');
    await FirebaseApi().inintNotifications();
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    _initPackageInfo();
    printIps();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp.router(
        title: 'فاتيه ـ متجر بطاقات الشحن والألعاب',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
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
        // initialRoute: SplashPage.routName,
        // routes: routes,

        routerConfig: router,
      ),
    );
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        Constants.userIp = addr.address;
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      Constants.packageInfo = info;
    });
  }
}
