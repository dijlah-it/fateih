import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
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
