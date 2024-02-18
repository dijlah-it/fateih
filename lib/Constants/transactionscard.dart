import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Constants/spacer_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:substring_highlight/substring_highlight.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
  });

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
          width: 2,
        ),
      ),
      child: Column(
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '2024-06-05 13:33:39',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              SpacerLine(),
              Text(
                '19090108776460',
                style: TextStyle(
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
                text: 'ZAIN_2000IQD Zain (SHARE)',
                term: 'SHARE',
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                textStyleHighlight: const TextStyle(
                  color: Constants.itemColor,
                ),
              ),
              InkWell(
                onTap: () {
                  debugPrint('statement');
                },
                child: const Icon(
                  Icons.share_outlined,
                  color: Constants.itemColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
