import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/spacer_line.dart';
import 'package:fateih/Constants/switch_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:substring_highlight/substring_highlight.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
    required this.serial,
    required this.date,
    required this.payment,
    this.sellText,
    this.icon,
    this.term,
  });
  final String serial;
  final String date;
  final String payment;
  final String? icon;
  final String? term;
  final String? sellText;

  @override
  Widget build(BuildContext context) {
    debugPrint("icon================>>${icon}");
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      constraints: BoxConstraints(
        maxWidth: 600,
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
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SpacerLine(),
                ),
              ),
              Text(
                serial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SubstringHighlight(
                text: payment,
                term: term,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                textStyleHighlight: const TextStyle(
                    color: Constants.itemColor, fontWeight: FontWeight.w700),
              ),
              icon != 'card' && icon != 'online_pay'
                  ? InkWell(
                      onTap: () async {
                        switchCall(sellText!, icon!, context);
                      },
                      child: Icon(
                        icon == 'نسخ'
                            ? Icons.copy
                            : icon == 'SMS'
                                ? Icons.sms
                                : icon == 'share'
                                    ? Icons.share
                                    : icon == 'تعبئة'
                                        ? Icons.chrome_reader_mode_outlined
                                        : icon == 'شراء'
                                            ? Icons.file_download_outlined
                                            : null,
                        color: Constants.secondColor,
                      ),
                    )
                  : icon == 'card'
                      ? SvgPicture.asset(
                          './assets/svgs/Group6413.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        )
                      : icon == 'online_pay'
                          ? SvgPicture.asset(
                              './assets/svgs/card-tick.svg',
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            )
                          : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
