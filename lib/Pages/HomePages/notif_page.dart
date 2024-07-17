import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  List<String> titleContent = [];
  List<String> bodyContent = [];
  List<String> dateContent = [];
  _getContents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      titleContent = pref.getStringList("titleContent") ?? [];
      bodyContent = pref.getStringList("bodyContent") ?? [];
      dateContent = pref.getStringList("dateContent") ?? [];
    });
  }

  @override
  void initState() {
    _getContents();
    super.initState();
    debugPrint('--------->' + bodyContent.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: bodyContent.isNotEmpty
          ? Column(
              children: [
                ...List.generate(bodyContent.length, (index) {
                  return NotifCard(
                    body: bodyContent[index],
                    date: dateContent[index],
                  );
                }),
              ],
            )
          : Center(
              child: Text(
                'لا توجد نتائج',
                style: TextStyle(
                  color: Constants.darkModeEnabled
                      ? Constants.backgroundColorDark
                      : Colors.white,
                ),
              ),
            ),
    );
  }
}

class NotifCard extends StatelessWidget {
  const NotifCard({
    super.key,
    required this.body,
    required this.date,
  });
  final String body;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("./assets/images/header-design.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        border: const GradientBoxBorder(
          gradient: Constants.appGradient,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.notifications_none,
            color: Constants.secondColor,
            size: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const Gap(15),
              Row(
                children: <Widget>[
                  Text(
                    body,
                    style: const TextStyle(
                      color: Constants.itemColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  // SvgPicture.asset(
                  //   './assets/svgs/card-tick.svg',
                  //   colorFilter:
                  //       const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
