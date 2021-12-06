import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:velocity_x/velocity_x.dart';

class AppNavbar extends StatefulWidget {
  const AppNavbar({Key? key, required this.onIndexChange}) : super(key: key);
  final NavbarCallback onIndexChange;

  @override
  _AppNavbarState createState() => _AppNavbarState();
}

typedef NavbarCallback = void Function(int);

class _AppNavbarState extends State<AppNavbar> {
  int index = 0;

  void changeIndex(int i) {
    setState(() {
      index = i;
    });
    widget.onIndexChange(i);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavbarItem(
            title: "Home",
            onTap: () => changeIndex(0),
            isExpanded: index == 0,
            icon: Icons.home_rounded,
            color: primaryColor(context),
          ),
          _NavbarItem(
            title: "Favourite",
            onTap: () => changeIndex(1),
            icon: Icons.home_rounded,
            isExpanded: index == 1,
            color: Colors.pink,
          ),
          _NavbarItem(
            title: "Profile",
            onTap: () => changeIndex(2),
            icon: Icons.person_rounded,
            isExpanded: index == 2,
            color: Colors.orange,
          ),
        ],
      ).p8(),
    );
  }
}

class _NavbarItem extends StatelessWidget {
  const _NavbarItem({
    Key? key,
    required this.title,
    this.isExpanded = false,
    required this.onTap,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return IconButton(
        icon: Icon(icon),
        onPressed: onTap,
      );
    }
    return Row(
      children: [
        Icon(icon, color: color),
        horSpacing10,
        title.text.color(color).make(),
      ],
    ).box.p4.color(color.withOpacity(0.5)).roundedLg.make();
  }
}
