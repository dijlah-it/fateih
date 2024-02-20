import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:gap/gap.dart';

class BuyCard extends StatefulWidget {
  const BuyCard({super.key});

  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  String? _choiceBuyCardtoolsItems;
  static const List<Object> _buyCardtoolsItems = [
    {"title": 'نسخ', "icon": Icons.copy_all_outlined},
    {"title": 'SMS', "icon": Icons.sms_failed_outlined},
    {"title": 'مشاركة', "icon": Icons.share_outlined},
    {"title": 'طباعة', "icon": Icons.print_outlined},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: List.generate(
          6,
          (index) => Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ExpansionTile(
                clipBehavior: Clip.antiAlias,
                backgroundColor: Colors.grey.withAlpha(50),
                collapsedBackgroundColor: Colors.grey.withAlpha(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                trailing: const SizedBox(),
                title: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image
                    Container(
                      padding: const EdgeInsets.all(1),
                      clipBehavior: Clip.antiAlias,
                      width: 140,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: Constants.appGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          './assets/images/example.jpg',
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'كرت ببجي',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Constants.themeColor,
                          ),
                        ),
                        Gap(10),
                        Text(
                          'سعر الكرت : 5000 ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Constants.backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              for (final item in _buyCardtoolsItems)
                                switch (item) {
                                  {
                                    'title': final String title,
                                    'icon': final IconData icon,
                                  } =>
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _choiceBuyCardtoolsItems = title;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              icon,
                                              color: _choiceBuyCardtoolsItems ==
                                                      title
                                                  ? Constants.itemColor
                                                  : Constants.secondColor,
                                              size: 30,
                                            ),
                                            const Gap(10),
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontFamily: 'dijlah',
                                                color:
                                                    _choiceBuyCardtoolsItems ==
                                                            title
                                                        ? Constants.itemColor
                                                        : Constants.secondColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  final v => throw Exception('what is $v'),
                                },
                            ],
                          ),
                          const Gap(10),
                          ActionSlider.standard(
                            direction: TextDirection.rtl,
                            action: (controller) async {
                              controller.loading();
                              await Future.delayed(const Duration(seconds: 3));
                              controller.success();
                            },
                            toggleColor: Constants.itemColor,
                            backgroundColor: Colors.white.withAlpha(50),
                            successIcon: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                            ),
                            failureIcon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.chevron_right_outlined,
                              color: Colors.white,
                            ),
                            loadingIcon: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                            height: 50,
                            width: size.width * 0.7,
                            borderWidth: 2.0,
                            child: const Text(
                              'اسحب للتاكيد',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
        ),
      ),
    );
  }
}
