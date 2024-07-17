import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:overlay_support/overlay_support.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        initialSettings: InAppWebViewSettings(),
        onUpdateVisitedHistory: (controller, url, isReload) {
          debugPrint('onUpdateVisitedHistory ====>' + url.toString());
          if (url.toString().contains('success')) {
            debugPrint('onUpdateVisitedHistory ====>success');
            Constants.inventoryFuture = WalletBalance(
              token: Constants.userTokenLocal.read('token'),
            ).then(
              (value) {
                showSimpleNotification(
                  Text(
                    "تم اضافة الرصيد بنجاح",
                    textAlign: TextAlign.right,
                  ),
                  background: Colors.green[600],
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
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
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.home_filled,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
