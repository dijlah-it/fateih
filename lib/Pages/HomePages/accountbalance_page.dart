import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    super.initState();
    // homeAPI(Constants.userTokenLocal.read('token'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: Container(
        child: Column(
          children: <Widget>[
            const Gap(10),
            Container(
              width: size.width,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (MediaQuery.of(context).size.width < 650) {
                    // phone
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: (Constants.homePages?['sliders']['slides']
                                  as List)
                              .length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              GestureDetector(
                            onTap: () {
                              debugPrint('statement');
                              _launchUrl(Uri.parse(
                                  Constants.homePages?['sliders']['slides']
                                          [itemIndex]['url'] ??
                                      'http://fatyh.net'));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.jpg',
                                image: Constants.homePages?['sliders']['slides']
                                    [itemIndex]['image'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            animateToClosest: true,
                            height: 140.0,
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
                            children: (Constants.homePages?['sliders']['slides']
                                    as List)
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () => _carouselController
                                    .animateToPage(entry.key),
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
                    );
                  } else {
                    //web
                    return Container(
                        child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 250.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      itemCount:
                          (((Constants.homePages?['sliders']['slides'] as List)
                                      .length) /
                                  2)
                              .round(),
                      itemBuilder: (context, index, realIdx) {
                        final int first = index * 2;
                        final int second = first + 1;
                        final int three = first + 2;
                        return Row(
                          children: [first, second, three].map((itemIndex) {
                            return Expanded(
                              flex: 1,
                              child: (Constants.homePages?['sliders']['slides']
                                              as List)
                                          .length >
                                      itemIndex
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          debugPrint('statement');
                                          _launchUrl(Uri.parse(
                                              Constants.homePages?['sliders']
                                                          ['slides'][itemIndex]
                                                      ['url'] ??
                                                  'http://fatyh.net'));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/placeholder.jpg',
                                            image: Constants
                                                    .homePages?['sliders']
                                                ['slides'][itemIndex]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          debugPrint('statement');
                                          _launchUrl(Uri.parse(
                                              Constants.homePages?['sliders']
                                                      ['slides'][0]['url'] ??
                                                  'http://fatyh.net'));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/placeholder.jpg',
                                            image:
                                                Constants.homePages?['sliders']
                                                    ['slides'][0]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          }).toList(),
                        );
                      },
                    ));
                  }
                },
              ),
            ),
            CardsWidget(
              widget: widget,
              categoriTitle: 'كروت الارصدة',
              count: (Constants.homePages?['categories'] as List).length,
              products: Constants.homePages?['categories'],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class CardsWidget extends StatelessWidget {
  final String categoriTitle;
  final int count;
  final List<dynamic> products;
  const CardsWidget({
    super.key,
    required this.widget,
    required this.categoriTitle,
    required this.count,
    required this.products,
  });

  final AccountBalance widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoriTitle,
              style: TextStyle(
                color: Constants.darkModeEnabled ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(5),
            buildGridView(size, products),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(Size size, List<dynamic> products) => Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: List.generate(
          count,
          (index) => InkWell(
            onTap: () {
              Constants.categoriesID = products[index]['id'];
              Constants.companyName = products[index]['name'];
              widget.callback(4);
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: 250),
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: Constants.backgroundColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.jpg',
                      image: products[index]['logo_url'],
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    products[index]['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Continental',
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(5),
                ],
              ),
            ),
          ),
        ),
      );
}
