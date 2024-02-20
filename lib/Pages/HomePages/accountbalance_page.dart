import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';

class AccountBalance extends StatefulWidget {
  final Function callback;

  const AccountBalance({
    super.key,
    required this.callback,
  });

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  _AccountBalanceState();
  int _current = 0;
  final CarouselController _carouselController = CarouselController();
  static const List<String> _sliderImageList = [
    'Rectangle 1102.jpg',
    'Rectangle 1102.jpg',
    'Rectangle 1102.jpg',
    'Rectangle 1102.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          const Gap(10),
          Column(
            children: [
              CarouselSlider.builder(
                itemCount: _sliderImageList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  color: Colors.red,
                  child: Image.asset(
                    './assets/images/${_sliderImageList[itemIndex]}',
                    fit: BoxFit.fill,
                  ),
                ),
                options: CarouselOptions(
                  animateToClosest: false,
                  height: 120.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _sliderImageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _current == entry.key ? 22.0 : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (Constants.themeColor).withOpacity(
                            _current == entry.key ? 0.9 : 0.4,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          // CarouselSlider.builder(
          //   itemCount: 4,
          //   itemBuilder:
          //       (BuildContext context, int itemIndex, int pageViewIndex) =>
          //           Container(
          //     color: Colors.red,
          //     child: Image.asset(
          //       './assets/images/Rectangle 1102.jpg',
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          //   options: CarouselOptions(
          //     disableCenter: true,
          //     autoPlay: true,
          //     aspectRatio: 2.0,
          //     enlargeCenterPage: true,
          //     height: 120,
          //   ),
          // ),
          CardsWidget(widget: widget),
          CardsWidget(widget: widget),
        ],
      ),
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({
    super.key,
    required this.widget,
  });

  final AccountBalance widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'كروت الالعاب',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 270,
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              controller: ScrollController(keepScrollOffset: false),
              children: List.generate(
                6,
                (index) => InkWell(
                  onTap: () {
                    widget.callback(4);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            './assets/images/example.jpg',
                            fit: BoxFit.fill,
                            height: 90,
                            width: size.width,
                          ),
                        ),
                        const Gap(3),
                        Text(
                          'كروت ببجي',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
