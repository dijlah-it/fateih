import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/transactionscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/carddesign.png',
                  fit: BoxFit.cover,
                  height: 160,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 30,
                bottom: 60,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    SvgPicture.asset(
                      './assets/svgs/dollarCard.svg',
                    ),
                    const Gap(5),
                    Text(
                      '4,840,200',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      ' دينار عراقي',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: 42.0,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    gradient: Constants.appGradient,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Working !!!');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Text(
                        'اضافة رصيد',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap(6),
                      Icon(
                        Icons.add_card,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 42.0,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Constants.secondColor,
                      Color.fromARGB(255, 242, 214, 117),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Working !!!');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'شحن اونلاين',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap(6),
                      Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
          const Text(
            'التقارير',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Constants.backgroundColor.withAlpha(30),
            ),
            child: Column(
              children: [
                ...List.generate(8, (index) {
                  return const TransactionsCard();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
