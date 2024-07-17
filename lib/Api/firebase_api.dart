import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> titleContent = [];
List<String> bodyContent = [];

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("title :${message.notification?.title}");
  debugPrint("body :${message.notification?.body}");
  debugPrint("payload :${message.data}");
  saveNotif(
    title: message.notification?.title,
    body: message.notification?.body,
    date: DateTime.now().toString(),
  );
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("TOKEN :$fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    _firebaseMessaging.isAutoInitEnabled;
  }
}

saveNotif({String? body, String? title, String? date}) async {
  titleContent.add(title!);
  bodyContent.add(body!);

  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setStringList("titleContent", titleContent);
  await pref.setStringList("bodyContent", bodyContent);
  await pref.setStringList("dateContent", bodyContent);

  debugPrint(titleContent.toString());
  debugPrint(bodyContent.toString());
}
