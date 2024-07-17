import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Constants {
  static const Color themeColor = Color.fromARGB(255, 19, 158, 141);
  static const Color itemColor = Color.fromARGB(255, 68, 237, 129);
  static const Color backgroundColorLight = Color.fromARGB(255, 14, 51, 43);
  static const Color secondColor = Color.fromARGB(255, 206, 190, 135);
  static const Color textColorLight = Colors.black;

  static bool darkModeEnabled = false;
  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  static const Color backgroundColorDark = Color.fromARGB(255, 3, 21, 18);
  static const Color textColorDark = Colors.white;

  static int activeHomePage = 0;
  static int categoriesID = 0;
  static String companyName = '';
  static String userPhoneNumber = '';
  static const LinearGradient appGradient = LinearGradient(
    colors: [
      Constants.themeColor,
      Constants.itemColor,
    ],
  );

  static Map<String, dynamic>? userData;
  static String userIp = '';
  // static Map<String, dynamic>? userToken;
  static Map<String, dynamic>? homePages;
  static Map<String, dynamic>? inventory;
  static Map<String, dynamic>? sellCard;
  static Map<String, dynamic>? products;
  static Map<String, dynamic>? reportSell;
  static Map<String, dynamic>? walletTransactions;
  static Future? inventoryFuture;
  static GetStorage userTokenLocal = GetStorage();
  static String userSimType = '';
  static int? userInventory = Constants.userData?['wallet_balance'] ?? 0000;
  static final StreamController<int?> stramWalletCtrl =
      StreamController<int?>.broadcast();
}
