import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';

class ContentPage extends StatefulWidget {
  final String title;
  final String text;
  const ContentPage({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Constants.darkModeEnabled ? Colors.white : Colors.black,
            ),
          ),
          const Gap(10),
          Container(
            width: size.width,
            constraints: BoxConstraints(
              maxHeight: size.height * 0.6,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Html(
                data: """
                  <!DOCTYPE html>
                    <html dir='rtl'>
                      <body>
                      <div style='direction: rtl;'>${widget.text}</div>
                        </body>
                      </html>
                    """,
                style: {
                  "p": Style(
                    lineHeight: const LineHeight(1.8),
                    fontSize: FontSize(16),
                    textAlign: TextAlign.justify,
                    color:
                        Constants.darkModeEnabled ? Colors.white : Colors.black,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
