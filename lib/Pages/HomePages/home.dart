import 'package:fateih/Api/api.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/accountbalance_page.dart';
import 'package:fateih/Pages/HomePages/buycard.dart';
import 'package:fateih/Pages/HomePages/content_page.dart';
import 'package:fateih/Pages/HomePages/notif_page.dart';
import 'package:fateih/Pages/HomePages/profile_page.dart';
import 'package:fateih/Pages/HomePages/setting_page.dart';
import 'package:fateih/Pages/HomePages/transactions_page.dart';
import 'package:fateih/Pages/HomePages/wallet_page.dart';
import 'package:fateih/Pages/StartPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  static String routName = "/HomePage";
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool collapse = true;
  final ScrollController _scrollController = ScrollController();
  final oCcy = intl.NumberFormat("#,##0", "en_US");

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

  late AnimationController _controller;
  Future? dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = homeAPI(Constants.userTokenLocal.read('token')).then(
      (value) {
        Constants.stramWalletCtrl.stream.listen((updateWallet) {
          setState(() {
            Constants.userInventory = updateWallet;
          });
        });
      },
    );

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // Constants.stramWalletCtrl.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.darkModeEnabled
          ? Constants.backgroundColorDark
          : Colors.white,
      body: FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Constants.darkModeEnabled
                      ? Colors.white
                      : Constants.backgroundColorDark,
                ),
              );
            case ConnectionState.done:
              return CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 270,
                    collapsedHeight:
                        (185 - MediaQuery.of(context).viewPadding.top),
                    pinned: true,
                    snap: false,
                    floating: false,
                    backgroundColor: Constants.darkModeEnabled
                        ? Constants.backgroundColorDark
                        : Colors.white,
                    flexibleSpace: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 35,
                          ),
                          width: double.infinity,
                          height: 300,
                          margin: const EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(
                            color: Constants.darkModeEnabled
                                ? Constants.backgroundColorDark
                                : Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                "./assets/images/header-design.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: <Widget>[
                              // header
                              Container(
                                height: 48,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          Constants.activeHomePage = 5;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/profile.png',
                                          image: Constants.userData?['user']
                                              ['profile_photo_url'],
                                          fit: BoxFit.fill,
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          const Text(
                                            'اهلا بك',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            Constants.userData?['user']
                                                    ['name'] ??
                                                '',
                                            style: const TextStyle(
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
                                          color: const Color.fromARGB(
                                              255, 12, 86, 69),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: GradientBoxBorder(
                                            gradient:
                                                Constants.activeHomePage != 9
                                                    ? Constants.appGradient
                                                    : const LinearGradient(
                                                        colors: [
                                                          Constants.secondColor,
                                                          Color.fromARGB(255,
                                                              242, 214, 117),
                                                        ],
                                                      ),
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: SvgPicture.asset(
                                            './assets/svgs/notif-icon.svg',
                                            colorFilter:
                                                Constants.activeHomePage != 9
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
                                    Gap(10),
                                    InkWell(
                                      onTap: () {
                                        confidenceDialog();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.red.withAlpha(70),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.red,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Icon(
                                            Icons.exit_to_app_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //payment
                              Container(
                                width: size.width,
                                height: 55,
                                constraints: BoxConstraints(maxWidth: 500),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
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
                                    const Text(
                                      'رصيدك الحالي :',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        oCcy.format(Constants.userInventory),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Text(
                                      'IQD',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            child: LayoutBuilder(
                                              builder: (BuildContext context,
                                                  BoxConstraints constraints) {
                                                if (MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    650) {
                                                  return Column(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 12, 86, 69),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border:
                                                              GradientBoxBorder(
                                                            gradient: Constants
                                                                        .activeHomePage !=
                                                                    tag
                                                                ? Constants
                                                                    .appGradient
                                                                : const LinearGradient(
                                                                    colors: [
                                                                      Constants
                                                                          .secondColor,
                                                                      Color.fromARGB(
                                                                          255,
                                                                          242,
                                                                          214,
                                                                          117),
                                                                    ],
                                                                  ),
                                                            width: 0.8,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(13.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            './assets/svgs/$path',
                                                            colorFilter: Constants
                                                                        .activeHomePage !=
                                                                    tag
                                                                ? const ColorFilter
                                                                    .mode(
                                                                    Colors
                                                                        .transparent,
                                                                    BlendMode
                                                                        .colorBurn,
                                                                  )
                                                                : const ColorFilter
                                                                    .mode(
                                                                    Constants
                                                                        .secondColor,
                                                                    BlendMode
                                                                        .srcIn,
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Gap(10),
                                                      Text(
                                                        title,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Constants
                                                                      .activeHomePage !=
                                                                  tag
                                                              ? Colors.white70
                                                              : Constants
                                                                  .secondColor,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 12, 86, 69),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border:
                                                              GradientBoxBorder(
                                                            gradient: Constants
                                                                        .activeHomePage !=
                                                                    tag
                                                                ? Constants
                                                                    .appGradient
                                                                : const LinearGradient(
                                                                    colors: [
                                                                      Constants
                                                                          .secondColor,
                                                                      Color.fromARGB(
                                                                          255,
                                                                          242,
                                                                          214,
                                                                          117),
                                                                    ],
                                                                  ),
                                                            width: 0.8,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(13.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            './assets/svgs/$path',
                                                            colorFilter: Constants
                                                                        .activeHomePage !=
                                                                    tag
                                                                ? const ColorFilter
                                                                    .mode(
                                                                    Colors
                                                                        .transparent,
                                                                    BlendMode
                                                                        .colorBurn,
                                                                  )
                                                                : const ColorFilter
                                                                    .mode(
                                                                    Constants
                                                                        .secondColor,
                                                                    BlendMode
                                                                        .srcIn,
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Gap(10),
                                                      Text(
                                                        title,
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          color: Constants
                                                                      .activeHomePage !=
                                                                  tag
                                                              ? Colors.white70
                                                              : Constants
                                                                  .secondColor,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        final v =>
                                          throw Exception('what is $v'),
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          child: Image.asset(
                            Constants.darkModeEnabled
                                ? './assets/images/4up-2.png'
                                : './assets/images/4up-1.png',
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
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 0.5)
                                    .animate(_controller),
                                child: Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  size: 40,
                                  color: Constants.themeColor,
                                ),
                              ),
                              // child: Icon(
                              //   collapse
                              //       ? Icons.keyboard_arrow_up_sharp
                              //       : Icons.keyboard_arrow_down_sharp,
                              //   color: Constants.themeColor,
                              //   size: 40,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: (size.height - 265) +
                            MediaQuery.of(context).viewPadding.top,
                      ),
                      child: _buildPages(),
                    ),
                  )
                ],
              );
            default:
              return const Text('defult');
          }
        },
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          selectedItemColor: Constants.itemColor,
          unselectedItemColor: Constants.secondColor,
          backgroundColor: Constants.backgroundColorLight,
          onTap: (i) {
            setState(() {
              _currentIndex = i;
              Constants.activeHomePage = i;
              debugPrint(collapse.toString());

              if (i == 0) {
                setState(() {
                  collapse = false;
                  _controller.forward();
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                });
              } else {
                setState(() {
                  collapse = true;
                  _controller.reverse();
                  _scrollController.animateTo(
                    110,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
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

  Future<void> confidenceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'هل أنت متأكد؟',
            textAlign: TextAlign.right,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'هل تريد تسجيل الخروج من حسابك؟',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // EXIT
              child: const Text('نعم'),
              onPressed: () {
                Constants.userTokenLocal.remove('token');
                GoRouter.of(context).pushReplacement(LogInPage.routName);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   LogInPage.routName,
                //   ModalRoute.withName('/'),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  callback(int activeHomePage) {
    setState(() {
      Constants.activeHomePage = activeHomePage;
    });
  }

  _buildPages() {
    switch (Constants.activeHomePage) {
      case 0:
        return AccountBalance(callback: callback);
      case 1:
        return ContentPage(
          title: Constants.homePages!['pages'][2]['title'],
          text: Constants.homePages!['pages'][2]['content'],
        );
      case 2:
        return ContentPage(
          title: Constants.homePages!['pages'][1]['title'],
          text: Constants.homePages!['pages'][1]['content'],
        );
      case 3:
        return ContentPage(
          title: Constants.homePages!['pages'][0]['title'],
          text: Constants.homePages!['pages'][0]['content'],
        );
      case 4:
        return BuyCard(
          categoriesID: Constants.categoriesID,
          callback: callback,
        );
      case 5:
        return const ProfilePage();
      case 6:
        return const TransactionsPage();
      case 7:
        return const WalletPage();
      case 8:
        return SettingPage(callback: callback);
      case 9:
        return const NotifPage();
      default:
        return const Center(
          child: Text('Hello Friend'),
        );
    }
  }

  collapsedSliverAppBar() {
    if (collapse) {
      setState(() {
        collapse = false;
        _controller.forward();
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else {
      setState(() {
        collapse = true;
        _controller.reverse();
        _scrollController.animateTo(
          110,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }
}
