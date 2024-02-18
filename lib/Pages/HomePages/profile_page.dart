import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:slide_switcher/slide_switcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _profileActiveTab = 0;

  static const List<Object> _profileInformationItems = [
    {
      "title": 'الاسم :',
      "subTitle": 'حسين الساعدي',
      "icon": Icons.person_outline
    },
    {
      "title": 'البريد الالكتروني :',
      "subTitle": 'info@dijlah.org',
      "icon": Icons.email_outlined
    },
    {
      "title": 'العنوان :',
      "subTitle": 'العراق - بغداد - شارع المنصور',
      "icon": Icons.location_on_outlined
    },
  ];
  static const List<Object> _profileAmendment = [
    {
      "title": 'الاسم :',
      "subTitle": 'حسين الساعدي',
      "icon": Icons.person_outline
    },
    {
      "title": 'البريد الالكتروني :',
      "subTitle": 'info@dijlah.org',
      "icon": Icons.email_outlined
    },
    {
      "title": 'العنوان :',
      "subTitle": 'العراق - بغداد - شارع المنصور',
      "icon": Icons.location_on_outlined
    },
    {
      "title": 'الانستا :',
      "subTitle": '@DIJLAH',
      "icon": Icons.facebook_outlined
    },
    {
      "title": 'فيس بوك :',
      "subTitle": '@DIJLAH',
      "icon": Icons.facebook_outlined
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            height: 125,
            decoration: BoxDecoration(
              color: Constants.backgroundColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: const GradientBoxBorder(
                gradient: Constants.appGradient,
                width: 0.8,
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    './assets/images/profile.jpg',
                    fit: BoxFit.cover,
                    height: 130,
                    width: 130,
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'حسين الساعدي',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          gradient: Constants.appGradient,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'info@dijlah.org',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Gap(5),
                          Icon(
                            Icons.alternate_email_sharp,
                            size: 15,
                            color: Constants.themeColor,
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: <Widget>[
                          Text(
                            '+964 777 7777 7777',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Gap(5),
                          Icon(
                            Icons.call_outlined,
                            size: 15,
                            color: Constants.themeColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Gap(20),
          SlideSwitcher(
            containerColor: Constants.backgroundColor.withOpacity(0.1),
            slidersGradients: const [Constants.appGradient],
            onSelect: (index) {
              setState(() {
                _profileActiveTab = index;
              });
            },
            isAllContainerTap: true,
            containerHeight: 40,
            containerWight: size.width - 40,
            children: [
              Text(
                'تعديل',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _profileActiveTab == 1 ? Colors.black : Colors.white,
                ),
              ),
              Text(
                'المعلومات الشخصية',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _profileActiveTab == 0 ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          const Gap(20),
          _profileActiveTab == 0
              ? Column(
                  children: <Widget>[
                    for (final item in _profileInformationItems)
                      switch (item) {
                        {
                          'title': final String title,
                          'subTitle': final String subTitle,
                          'icon': final IconData icon,
                        } =>
                          ProfileItem(
                            icon: icon,
                            subTitle: subTitle,
                            title: title,
                          ),
                        final v => throw Exception('what is $v'),
                      },
                    const Gap(10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('Working !!!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.itemColor,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'حفظ التعديل',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    for (final item in _profileAmendment)
                      switch (item) {
                        {
                          'title': final String title,
                          'subTitle': final String subTitle,
                          'icon': final IconData icon,
                        } =>
                          ProfileItem(
                            icon: icon,
                            subTitle: subTitle,
                            title: title,
                          ),
                        final v => throw Exception('what is $v'),
                      },
                    const Gap(10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('Working !!!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'تسجيل الخروج ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.backgroundColor.withOpacity(0.1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: 150,
            decoration: const BoxDecoration(
              color: Constants.themeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(5),
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
