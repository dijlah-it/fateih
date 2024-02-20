import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/accountbalance_page.dart';
import 'package:fateih/Pages/HomePages/buycard.dart';
import 'package:fateih/Pages/HomePages/content_page.dart';
import 'package:fateih/Pages/HomePages/notif_page.dart';
import 'package:fateih/Pages/HomePages/profile_page.dart';
import 'package:fateih/Pages/HomePages/setting_page.dart';
import 'package:fateih/Pages/HomePages/transactions_page.dart';
import 'package:fateih/Pages/HomePages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  static String routName = "HomePage";
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double collapsedHeight = 165;
  double expandedHeight = 290;
  int _currentIndex = 0;
  bool collapse = true;

  static const List<Object> _headerButtonsGroup = [
    {"title": 'المحفطة', "path": 'wallet-icon.svg', "tag": 7},
    {"title": 'التقارير', "path": 'reports-icon.svg', "tag": 6},
    {"title": 'الاعدادات', "path": 'setting-icon.svg', "tag": 8},
    {"title": 'الکروت', "path": 'card-grad.svg', "tag": 0},
  ];
  static const List<Object> _navigationBarItemsd = [
    {"title": 'الرئيسية', "icon": Icons.home_rounded},
    {"title": 'الدعم الفني', "icon": Icons.support_agent_outlined},
    {"title": 'الشروط', "icon": Icons.text_snippet_outlined},
    {"title": 'حول التطبيق', "icon": Icons.contact_support_outlined},
  ];

  List<Widget> _pages() {
    return [
      AccountBalance(callback: callback),
      const ContentPage(),
      const ContentPage(),
      const ContentPage(),
      const BuyCard(),
      const ProfilePage(),
      const TransactionsPage(),
      const WalletPage(),
      const SettingPage(),
      const NotifPage(),
    ];
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            pinned: true,
            snap: false,
            floating: false,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: collapse ? 320 : 190,
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 35,
                  ),
                  margin: const EdgeInsets.only(bottom: 2),
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("./assets/images/header-design.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Wrap(
                    children: <Widget>[
                      // header
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              debugPrint('eww');
                              setState(() {
                                Constants.activeHomePage = 5;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                './assets/images/profile.jpg',
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'اهلا بك',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  'حسين علي محمد',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Constants.activeHomePage = 9;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 12, 86, 69),
                                borderRadius: BorderRadius.circular(10),
                                border: GradientBoxBorder(
                                  gradient: Constants.activeHomePage != 9
                                      ? Constants.appGradient
                                      : const LinearGradient(
                                          colors: [
                                            Constants.secondColor,
                                            Color.fromARGB(255, 242, 214, 117),
                                          ],
                                        ),
                                  width: 0.8,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: SvgPicture.asset(
                                  './assets/svgs/notif-icon.svg',
                                  colorFilter: Constants.activeHomePage != 9
                                      ? const ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.colorBurn,
                                        )
                                      : const ColorFilter.mode(
                                          Constants.secondColor,
                                          BlendMode.srcIn,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //payment
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Constants.themeColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(10),
                          border: const GradientBoxBorder(
                            gradient: Constants.appGradient,
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text(
                              'رصيدك المتبقي: ',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            ShimmerEffect(
                              baseColor: Colors.white,
                              highlightColor: Constants.secondColor,
                              duration: const Duration(seconds: 3),
                              child: Text(
                                ' 4,840,200 ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              'دينار عراقي',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //items
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          for (final item in _headerButtonsGroup)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: switch (item) {
                                {
                                  'title': final String title,
                                  'path': final String path,
                                  'tag': final int tag,
                                } =>
                                  GestureDetector(
                                    onTap: () {
                                      debugPrint(tag.toString());
                                      setState(() {
                                        Constants.activeHomePage = tag;
                                      });
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 12, 86, 69),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: GradientBoxBorder(
                                              gradient: Constants
                                                          .activeHomePage !=
                                                      tag
                                                  ? Constants.appGradient
                                                  : const LinearGradient(
                                                      colors: [
                                                        Constants.secondColor,
                                                        Color.fromARGB(
                                                            255, 242, 214, 117),
                                                      ],
                                                    ),
                                              width: 0.8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: SvgPicture.asset(
                                              './assets/svgs/$path',
                                              colorFilter:
                                                  Constants.activeHomePage !=
                                                          tag
                                                      ? const ColorFilter.mode(
                                                          Colors.transparent,
                                                          BlendMode.colorBurn,
                                                        )
                                                      : const ColorFilter.mode(
                                                          Constants.secondColor,
                                                          BlendMode.srcIn,
                                                        ),
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Constants.activeHomePage != tag
                                                    ? Colors.white70
                                                    : Constants.secondColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                final v => throw Exception('what is $v'),
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  child: Image.asset(
                    './assets/images/4up-1.png',
                    height: 20,
                  ),
                ),
                Positioned(
                  bottom: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: InkWell(
                      onTap: () {
                        collapsedSliverAppBar();
                      },
                      child: Icon(
                        collapse
                            ? Icons.keyboard_arrow_up_sharp
                            : Icons.keyboard_arrow_down_sharp,
                        color: Constants.themeColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SliverToBoxAdapter(
          //   child: IndexedStack(
          //     index: Constants.activeHomePage,
          //     children: _pages(),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Constants.activeHomePage == 0
                ? AccountBalance(callback: callback)
                : Constants.activeHomePage == 1
                    ? const ContentPage()
                    : Constants.activeHomePage == 2
                        ? const ContentPage()
                        : Constants.activeHomePage == 3
                            ? const ContentPage()
                            : Constants.activeHomePage == 4
                                ? const BuyCard()
                                : Constants.activeHomePage == 5
                                    ? const ProfilePage()
                                    : Constants.activeHomePage == 6
                                        ? const TransactionsPage()
                                        : Constants.activeHomePage == 7
                                            ? const WalletPage()
                                            : Constants.activeHomePage == 8
                                                ? const SettingPage()
                                                : const NotifPage(),
          ),
        ],
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          selectedItemColor: Constants.itemColor,
          unselectedItemColor: Constants.secondColor,
          backgroundColor: Constants.backgroundColor,
          onTap: (i) {
            setState(() {
              _currentIndex = i;
              Constants.activeHomePage = i;
              collapsedHeight = 165;

              debugPrint(collapse.toString());
              if (i == 0) {
                expandedHeight = 290;
                collapse = true;
              } else {
                collapse = false;
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    expandedHeight = 165;
                  });
                });
              }
            });
          },
          items: [
            for (final item in _navigationBarItemsd)
              switch (item) {
                {
                  'title': final String title,
                  'icon': final IconData icon,
                } =>
                  SalomonBottomBarItem(
                    icon: Icon(
                      icon,
                      size: 28,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'dijlah',
                        fontSize: 13,
                      ),
                    ),
                  ),
                final v => throw Exception('what is $v'),
              },
          ],
        ),
      ),
    );
  }

  callback(activeHomePage) {
    setState(() {
      Constants.activeHomePage = activeHomePage;
    });
  }

  collapsedSliverAppBar() {
    collapsedHeight = 165;
    debugPrint(collapse.toString());
    if (collapse) {
      setState(() {
        collapse = false;
        // Future.delayed(const Duration(milliseconds: 200), () {
        //   if (collapsedHeight - expandedHeight != 0) {
        //     expandedHeight = 165;
        //   } else {
        //     expandedHeight = 290;
        //   }
        // });
        _scrollController.animateTo(130,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
      // });
    } else {
      setState(() {
        collapse = true;
        // Future.delayed(const Duration(milliseconds: 200), () {
        //   if (collapsedHeight - expandedHeight != 0) {
        //     expandedHeight = 165;
        //   } else {
        //     expandedHeight = 290;
        //   }
        // });
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
      // Future.delayed(const Duration(milliseconds: 50), () {

      // });
    }
  }
}
