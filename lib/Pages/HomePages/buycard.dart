import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/switch_call.dart';
import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:gap/gap.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart' as intl;
import 'package:substring_highlight/substring_highlight.dart';

class BuyCard extends StatefulWidget {
  final int categoriesID;
  final Function callback;
  const BuyCard({
    super.key,
    required this.categoriesID,
    required this.callback,
  });

  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  String? _choiceBuyCardtoolsItems;
  final oCcy = intl.NumberFormat("#,##0", "en_US");
  Future? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = productsAPI(
        Constants.userTokenLocal.read('token'), widget.categoriesID.toString());
    if (kIsWeb) {
      _buyCardtoolsItems
          .add({'title': 'شراء', 'icon': Icons.file_download_outlined});
    } else {
      _buyCardtoolsItems.addAll([
        {'title': 'SMS', 'icon': Icons.sms_failed_outlined},
        {'title': 'نسخ', 'icon': Icons.copy_all_outlined},
      ]);
      if (Constants.companyName == Constants.userSimType) {
        _buyCardtoolsItems
            .add({'title': 'تعبئة', 'icon': Icons.chrome_reader_mode_outlined});
      }
    }
  }

  final List<Object> _buyCardtoolsItems = [
    {'title': 'مشاركة', 'icon': Icons.share_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 10,
            top: 10,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.withAlpha(100),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              widget.callback(0);
            },
            child: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
        ),
        FutureBuilder(
          future: _productsFuture,
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
                    color: Constants.itemColor,
                  ),
                );
              case ConnectionState.done:
                return Container(
                  width: size.width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (snapshot.data['products'] as List).isNotEmpty
                      ? Column(
                          children: [
                            ...List.generate(
                              (snapshot.data['products'] as List).length,
                              (index) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 500),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ExpansionTile(
                                    key: Key(index.toString()),
                                    clipBehavior: Clip.antiAlias,
                                    backgroundColor: Colors.grey.withAlpha(50),
                                    collapsedBackgroundColor:
                                        Colors.grey.withAlpha(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    trailing: const SizedBox(),
                                    title: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // Image
                                        Container(
                                          padding: const EdgeInsets.all(1),
                                          clipBehavior: Clip.antiAlias,
                                          height: 100,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            gradient: Constants.appGradient,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/placeholder.jpg',
                                              image: snapshot.data['products']
                                                  [index]['logo_url'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        //line
                                        const Gap(10),
                                        Container(
                                          width: 1,
                                          height: 80,
                                          decoration: const BoxDecoration(
                                            gradient: Constants.appGradient,
                                          ),
                                        ),
                                        const Gap(10),
                                        //title
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              Constants.companyName,
                                              textDirection: TextDirection.rtl,
                                              style: const TextStyle(
                                                color: Constants.themeColor,
                                              ),
                                            ),
                                            const Gap(10),
                                            SubstringHighlight(
                                              text:
                                                  'سعر الكرت : IQD ${oCcy.format(snapshot.data['products'][index]['consumer_price_dinar'] ?? snapshot.data['products'][index]['price_dinar'])} ',
                                              term: oCcy.format(snapshot
                                                              .data['products']
                                                          [index][
                                                      'consumer_price_dinar'] ??
                                                  snapshot.data['products']
                                                      [index]['price_dinar']),
                                              textStyle: TextStyle(
                                                color: Constants.darkModeEnabled
                                                    ? Colors.white
                                                    : Colors.black54,
                                                fontSize: 15,
                                              ),
                                              textStyleHighlight:
                                                  const TextStyle(
                                                color: Constants.themeColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Constants.backgroundColorLight,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: <Widget>[
                                                  for (final item
                                                      in _buyCardtoolsItems)
                                                    switch (item) {
                                                      {
                                                        'title': final String
                                                            title,
                                                        'icon': final IconData
                                                            icon,
                                                      } =>
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              _choiceBuyCardtoolsItems =
                                                                  title;
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            width: 60,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Icon(
                                                                  icon,
                                                                  color: _choiceBuyCardtoolsItems == title
                                                                      ? Constants
                                                                          .itemColor
                                                                      : Constants
                                                                          .secondColor,
                                                                  size: 30,
                                                                ),
                                                                const Gap(10),
                                                                Text(
                                                                  title,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'dijlah',
                                                                    color: _choiceBuyCardtoolsItems ==
                                                                            title
                                                                        ? Constants
                                                                            .itemColor
                                                                        : Constants
                                                                            .secondColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      final v =>
                                                        throw Exception(
                                                            'what is $v'),
                                                    },
                                                ],
                                              ),
                                              const Gap(10),
                                              Visibility(
                                                visible:
                                                    _choiceBuyCardtoolsItems ==
                                                            null
                                                        ? false
                                                        : true,
                                                child: ActionSlider.standard(
                                                  direction: TextDirection.rtl,
                                                  actionThresholdType:
                                                      ThresholdType.release,
                                                  // stateChangeCallback: (oldState,
                                                  //     state, controller) {
                                                  //   if (_choiceBuyCardtoolsItems ==
                                                  //       null) {
                                                  //     controller.failure();
                                                  //   }
                                                  // },
                                                  action: (controller) async {
                                                    controller.loading();

                                                    debugPrint(
                                                        '1111111111111111');
                                                    sellCard(
                                                      Constants.userTokenLocal
                                                          .read('token'),
                                                      snapshot.data['products']
                                                              [index]['id']
                                                          .toString(),
                                                      snapshot.data['products']
                                                              [index][
                                                              'product_category_id']
                                                          .toString(),
                                                      _choiceBuyCardtoolsItems!,
                                                    ).then(
                                                      (value) async {
                                                        controller.success();

                                                        debugPrint(
                                                            '<<<-----------------11');
                                                        debugPrint(Constants
                                                            .sellCard![
                                                                'wallet_balance']
                                                            .toString());
                                                        Constants
                                                            .stramWalletCtrl
                                                            .sink
                                                            .add(Constants
                                                                .sellCard![
                                                                    'wallet_balance']
                                                                .toInt());
                                                        String sellText =
                                                            "serial: ${Constants.sellCard!['card']['serial']}\n pin: ${Constants.sellCard!['card']['pin']}\n expiration_date: ${Constants.sellCard!['card']['expiration_date']}\n${'ارسل بواسطة (${Constants.userData?['user']['name'] ?? ''}) / تطبيق فاتيه'} ";
                                                        switchCall(
                                                            sellText,
                                                            _choiceBuyCardtoolsItems!,
                                                            context);
                                                        setState(() {
                                                          _choiceBuyCardtoolsItems =
                                                              null;
                                                        });
                                                        showSimpleNotification(
                                                          Text(
                                                            'تمت عملية الشراء بشكل صحيح',
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                          background:
                                                              Colors.green[600],
                                                        );
                                                      },
                                                    ).catchError(
                                                        (onError) async {
                                                      debugPrint(
                                                          onError.toString());
                                                      controller.failure();
                                                      showSimpleNotification(
                                                        Text(
                                                          onError.toString(),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        background:
                                                            Colors.red[600],
                                                      );
                                                      setState(() {
                                                        _choiceBuyCardtoolsItems =
                                                            null;
                                                      });
                                                    });
                                                  },
                                                  toggleColor:
                                                      Constants.itemColor,
                                                  backgroundColor: Colors.white
                                                      .withAlpha(50),
                                                  successIcon: const Icon(
                                                    Icons.check_rounded,
                                                    color: Colors.white,
                                                  ),
                                                  failureIcon: const Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.white,
                                                  ),
                                                  icon: const Icon(
                                                    Icons
                                                        .chevron_right_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  loadingIcon:
                                                      const CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                  height: 50,
                                                  width: 250,
                                                  borderWidth: 2.0,
                                                  child: const Text(
                                                    'اسحب للتاكيد',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Gap(10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text(
                            'لا توجد كروت متاحة لهذه الفئة',
                            style: TextStyle(
                              color: Constants.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                );
              default:
                return const Text('defult');
            }
          },
        ),
      ],
    );
  }
}
