import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:gap/gap.dart';

class BuyCard extends StatefulWidget {
  const BuyCard({super.key});

  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  static const List<Object> _buyCardtoolsItems = [
    {"title": 'نسخ', "icon": Icons.copy_all_outlined},
    {"title": 'SMS', "icon": Icons.sms_failed_outlined},
    {"title": 'مشاركة', "icon": Icons.share_outlined},
    {"title": 'طباعة', "icon": Icons.print_outlined},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(
        6,
        (index) => Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Accordion(
            headerBackgroundColorOpened:
                Constants.backgroundColor.withOpacity(0.1),
            contentBackgroundColor: Constants.backgroundColor,
            contentBorderColor: Constants.backgroundColor.withOpacity(0.1),
            headerBackgroundColor: Constants.backgroundColor.withOpacity(0.1),
            contentHorizontalPadding: 20,
            paddingListBottom: 0,
            paddingBetweenClosedSections: 0,
            paddingBetweenOpenSections: 0,
            paddingListTop: 0,
            paddingListHorizontal: 0,
            scaleWhenAnimating: false,
            disableScrolling: true,
            openAndCloseAnimation: true,
            children: <AccordionSection>[
              AccordionSection(
                isOpen: false,
                headerBorderWidth: 0,
                contentVerticalPadding: 15,
                headerPadding: const EdgeInsets.all(10),
                rightIcon: const Text(""),
                header: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image
                    Container(
                      padding: const EdgeInsets.all(1),
                      clipBehavior: Clip.antiAlias,
                      width: 170,
                      height: 120,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'كرت ببجي',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Constants.themeColor,
                          ),
                        ),
                        const Gap(10),
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
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 43,
                      width: size.width * 0.7,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Constants.secondColor,
                            ),
                            child: Center(
                              child: Text(
                                'الكمية :',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      icon,
                                      color: Constants.secondColor,
                                      size: 30,
                                    ),
                                    const Gap(10),
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontFamily: 'Jazeera',
                                        color: Constants.secondColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            final v => throw Exception('what is $v'),
                          },
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
