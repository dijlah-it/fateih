import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/report_sell_cart.dart';
import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' as intl;

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();

  List<String> categoryList = ['الکل'];
  String dropdownCategoryValue = 'الکل';
  String productCategoryId = '0';

  List<String> productList = ['الکل'];
  String dropdownProductValue = 'الکل';
  String productId = '0';
  Future? _reportSellFuture;
  @override
  void initState() {
    super.initState();
    for (var i = 0;
        i < (Constants.homePages!['categories'] as List).length;
        i++) {
      categoryList.add(Constants.homePages!['categories'][i]['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("./assets/images/header-design.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Constants.secondColor,
                  height: double.infinity,
                  child: const Icon(
                    Icons.date_range_outlined,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Constants.themeColor,
                          ),
                          const Gap(5),
                          InkWell(
                            child: Text(
                              BoardDateFormat('yyyy/MM/dd').format(dateStart),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              debugPrint(dateStart.toString());
                              final result = await showBoardDateTimePicker(
                                context: context,
                                pickerType: DateTimePickerType.date,
                                options: const BoardDateTimeOptions(
                                  activeColor: Colors.black,
                                  showDateButton: false,
                                  pickerFormat: PickerFormat.ymd,
                                  boardTitle: 'حدد التاريخ المطلوب',
                                  boardTitleTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(
                                  () {
                                    dateStart = result;
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'الى',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Constants.secondColor,
                          ),
                          const Gap(5),
                          InkWell(
                            child: Text(
                              BoardDateFormat('yyyy/MM/dd').format(dateEnd),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              final result = await showBoardDateTimePicker(
                                context: context,
                                pickerType: DateTimePickerType.date,
                                options: const BoardDateTimeOptions(
                                  activeColor: Colors.black,
                                  showDateButton: false,
                                  pickerFormat: PickerFormat.ymd,
                                  boardTitle: 'حدد التاريخ المطلوب',
                                  boardTitleTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() => dateEnd = result);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Container(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownMenu<String>(
                    initialSelection: categoryList.first,
                    textStyle: TextStyle(
                      color: Constants.darkModeEnabled
                          ? Colors.white70
                          : Colors.black87,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      constraints:
                          BoxConstraints.tight(const Size.fromHeight(50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSelected: (String? value) {
                      setState(() {
                        productList = ['الکل'];
                        productCategoryId =
                            categoryList.indexOf(value!).toString();
                        productsAPI(Constants.userTokenLocal.read('token'),
                                categoryList.indexOf(value).toString())
                            .then(
                          (value) {
                            setState(() {
                              for (var i = 0;
                                  i <
                                      (Constants.products!['products'] as List)
                                          .length;
                                  i++) {
                                productList.add(Constants.products!['products']
                                    [i]['title']);
                              }
                            });
                          },
                        );
                        dropdownCategoryValue = value;
                      });
                    },
                    dropdownMenuEntries: categoryList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownMenu<String>(
                    initialSelection: productList.first,
                    textStyle: TextStyle(
                      color: Constants.darkModeEnabled
                          ? Colors.white70
                          : Colors.black87,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      constraints:
                          BoxConstraints.tight(const Size.fromHeight(50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSelected: (String? value) {
                      setState(() {
                        productId = productList.indexOf(value!).toString();
                        dropdownProductValue = value;
                      });
                    },
                    dropdownMenuEntries: productList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: () {
              debugPrint(intl.DateFormat("yyyy-MM-dd").format(dateStart));
              debugPrint(intl.DateFormat("yyyy-MM-dd").format(dateEnd));
              debugPrint(productId);
              debugPrint(productCategoryId);
              setState(() {
                _reportSellFuture = reportSell(
                  Constants.userTokenLocal.read('token'),
                  intl.DateFormat("yyyy-MM-dd").format(dateStart),
                  intl.DateFormat("yyyy-MM-dd").format(dateEnd),
                  productId,
                  productCategoryId,
                );
              });
            },
            child: const Text('إرسال'),
          ),
          const Gap(10),
          FutureBuilder(
              future: _reportSellFuture,
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
                        color: Colors.red,
                      ),
                    );
                  case ConnectionState.done:
                    return (snapshot.data['cards'] as List).isNotEmpty
                        ? Column(
                            children: [
                              ...List.generate(
                                  (snapshot.data['cards'] as List).length,
                                  (index) {
                                return ReportSellCart(
                                  serial: snapshot.data['cards'][index]
                                      ['serial'],
                                  date: snapshot.data['cards'][index]
                                          ['print_date']
                                      .toString(),
                                  icon: snapshot.data['cards'][index]
                                      ['sell_type'],
                                  payment: snapshot.data['cards'][index]
                                          ['company_name'] +
                                      snapshot.data['cards'][index]
                                          ['card_title'],
                                  term: snapshot.data['cards'][index]
                                      ['card_title'],
                                  sellText:
                                      "serial: ${snapshot.data['cards'][index]['serial']}\n pin: ${snapshot.data['cards'][index]['pin']}\n expiration_date: ${snapshot.data['cards'][index]['expiration_date']}\n${'ارسل بواسطة (${Constants.userData?['user']['name'] ?? ''}) / تطبيق فاتيه'} ",
                                  expiration: snapshot.data['cards'][index]
                                      ['expiration_date'],
                                  pin: snapshot.data['cards'][index]
                                      ['pin'],
                                );
                              }),
                            ],
                          )
                        : const Text('لا توجد نتائج');
                  default:
                    return const Text('defult');
                }
              }),
        ],
      ),
    );
  }
}
