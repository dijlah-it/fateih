import 'dart:async';

import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/transactionscard.dart';
import 'package:fateih/Pages/HomePages/paymen_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' as intl;
import 'package:overlay_support/overlay_support.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController _controllerPinCode = TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();
  final _pinCodeForm = GlobalKey<FormState>();
  final _paymentForm = GlobalKey<FormState>();
  final oCcy = intl.NumberFormat("#,##0", "en_US");
  Future? _inventoryTransactionsFuture;
  @override
  void initState() {
    super.initState();
    _inventoryTransactionsFuture =
        walletTransactions(Constants.userTokenLocal.read('token'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(25),
      width: size.width,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/carddesign.png',
                  fit: BoxFit.fill,
                  height: 160,
                ),
              ),
              Positioned(
                right: 30,
                bottom: 60,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    SvgPicture.asset(
                      './assets/svgs/dollarCard.svg',
                    ),
                    const Gap(5),
                    Text(
                      oCcy.format(Constants.userInventory),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      ' دينار عراقي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 42.0,
                decoration: BoxDecoration(
                    gradient: Constants.appGradient,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Working !!!');
                    _chargeWalletDialog();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shadowColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    './assets/svgs/Group6413.svg',
                  ),
                ),
              ),
              Gap(20),
              Container(
                height: 42.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Constants.secondColor,
                      Color.fromARGB(255, 242, 214, 117),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Working !!!');
                    _chargeWalletOnlineDialog();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shadowColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    './assets/svgs/card-tick.svg',
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
          Text(
            'تاريخ التعاملات المالية',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Constants.darkModeEnabled
                  ? Constants.textColorDark
                  : Constants.textColorLight,
            ),
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder(
              future: _inventoryTransactionsFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('');
                  case ConnectionState.active:
                    return const Text('none');
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Constants.themeColor,
                      ),
                    );
                  case ConnectionState.done:
                    return Column(
                      children: [
                        ...List.generate(
                            (snapshot.data['cards'] as List).length, (index) {
                          return TransactionsCard(
                            serial: '',
                            date: snapshot.data['cards'][index]['created_at'],
                            payment: oCcy.format(
                                snapshot.data['cards'][index]['amount']),
                            icon: snapshot.data['cards'][index]['charge_type'],
                            term: oCcy.format(
                                snapshot.data['cards'][index]['amount']),
                          );
                        }),
                      ],
                    );
                  default:
                    return const Text('defult');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: FutureBuilder(
              future: Constants.inventoryFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('');
                  case ConnectionState.active:
                    return const Text('none');
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.data?['error'] == null) {
                      Navigator.of(context).pop();
                      return const SizedBox();
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          snapshot.data?['error'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  default:
                    return const Text('defult');
                }
              }),
        );
      },
    );
  }

  Future<void> _chargeWalletOnlineDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'شحن رصيد اونلاين',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'د.ع',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Gap(5),
                    Form(
                      key: _paymentForm,
                      child: Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل الرمز فارغ';
                            } else if (value.length < 2) {
                              return 'عدد الارقام المدخل غير صحيح';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          controller: _controllerAmount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'المبلغ',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.themeColor, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.backgroundColorLight,
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelStyle: TextStyle(
                              color: Constants.themeColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('الغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('اضافة'),
                  onPressed: () {
                    if (_paymentForm.currentState!.validate()) {
                      Constants.inventoryFuture = chargeWallet(
                        token: Constants.userTokenLocal.read('token'),
                        type: 'online_pay',
                        amount: _controllerAmount.text,
                        currency: 'IQD',
                        userIp: Constants.userIp,
                      ).then(
                        (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentWebview(
                                url: value['redirectUrl'],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> _chargeWalletDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'يرجى ادخال الرقم السري',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _pinCodeForm,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'حقل الرمز فارغ';
                      } else if (value.length != 12) {
                        return 'عدد الارقام المدخل غير صحيح';
                      }
                      return null;
                    },
                    controller: _controllerPinCode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'pincode',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.themeColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.backgroundColorLight, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      labelStyle: TextStyle(
                        color: Constants.themeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('اضافة'),
              onPressed: () {
                debugPrint(_controllerPinCode.text);
                if (_pinCodeForm.currentState!.validate()) {
                  Navigator.of(context).pop();
                  setState(() {
                    Constants.inventoryFuture = chargeWallet(
                      token: Constants.userTokenLocal.read('token'),
                      cardPin: _controllerPinCode.text,
                      type: 'card',
                    ).then(
                      (value) {
                        setState(() {
                          Constants.userInventory =
                              Constants.inventory?['wallet_balance'];
                          Constants.stramWalletCtrl.sink
                              .add(Constants.inventory?['wallet_balance']);
                        });
                        showSimpleNotification(
                          Text(
                            "تم اضافة الرصيد بنجاح",
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

                  _showMyDialog();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
