import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

switchCall(String sellText, String choiceBuyCardtoolsItems, context) async {
  switch (choiceBuyCardtoolsItems) {
    case 'مشاركة':
      final box = context.findRenderObject() as RenderBox?;
      Share.share(
        sellText,
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      break;
    case 'نسخ':
      await Clipboard.setData(
        ClipboardData(text: sellText),
      );
      break;
    case 'شراء':
      final bytes = utf8.encode(sellText);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'fateih --' + DateTime.now().toString() + '.txt';
      html.document.body?.children.add(anchor);
      // download
      anchor.click();
      // cleanup
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
      break;
    case 'SMS':
      _sendSMS(sellText, []);
      break;
    case 'تعبئة':
      switch (Constants.userSimType) {
        case 'ASIACELL':
          _callNumber('*133*${Constants.sellCard!['card']['serial']}} #');
          break;
        case 'ZAIN':
          _callNumber('*101*${Constants.sellCard!['card']['serial']}} #');
          break;
        case 'KOREK':
          _callNumber('*221*${Constants.sellCard!['card']['serial']}} #');
          break;
        default:
      }

      break;
    default:
  }
}

_callNumber(String ussd) async {
  await FlutterPhoneDirectCaller.callNumber(ussd);
}

void _sendSMS(String message, List<String> recipents) async {
  String result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    debugPrint(onError);
    return '';
  });
  debugPrint(result);
}
