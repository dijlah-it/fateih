import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/transactionscard.dart';
import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:gap/gap.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
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
                  child: const Row(
                    children: <Widget>[
                      Text(
                        'التاريخ :',
                        style: TextStyle(color: Colors.white),
                        textDirection: TextDirection.rtl,
                      ),
                      Gap(10),
                      Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
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
                              debugPrint('eeeeeeeeeeeeee');
                              final result = await showBoardDateTimePicker(
                                context: context,
                                pickerType: DateTimePickerType.date,
                                options: const BoardDateTimeOptions(
                                  activeColor: Colors.black,
                                  showDateButton: false,
                                  pickerFormat: PickerFormat.ymd,
                                  boardTitle: 'تاريخ الانشاء',
                                  boardTitleTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() => dateStart = result);
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
                              debugPrint('eeeeeeeeeeeeee');
                              final result = await showBoardDateTimePicker(
                                context: context,
                                pickerType: DateTimePickerType.date,
                                options: const BoardDateTimeOptions(
                                  activeColor: Colors.black,
                                  showDateButton: false,
                                  pickerFormat: PickerFormat.ymd,
                                  boardTitle: 'تاريخ الانشاء',
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
          const Gap(20),
          ...List.generate(8, (index) {
            return const TransactionsCard();
          }),
        ],
      ),
    );
  }
}

