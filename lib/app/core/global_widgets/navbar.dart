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

class _Placeholder extends StatelessWidget {
  const _Placeholder({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(child: Center(child: child)));
  }
}

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Placeholder(
            child: _NavbarItem(
              title: "Home",
              onTap: () => changeIndex(0),
              isExpanded: index == 0,
              icon: Icons.home_rounded,
              color: primaryColor(context),
            ),
          ),
          _Placeholder(
            child: _NavbarItem(
              title: "Favourite",
              onTap: () => changeIndex(1),
              icon: Icons.favorite_rounded,
              isExpanded: index == 1,
              color: Colors.pink,
            ),
          ),
          _Placeholder(
            child: _NavbarItem(
              title: "Profile",
              onTap: () => changeIndex(2),
              icon: Icons.person_rounded,
              isExpanded: index == 2,
              color: Colors.orange,
            ),
          ),
        ],
      ).p12(),
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
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
      transitionBuilder: (child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: !isExpanded
          ? IconButton(
              icon: Icon(icon),
              color: Colors.grey,
              onPressed: onTap,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color),
                horSpacing10,
                title.text.bold.size(16).color(color).make(),
              ],
            ).py8().box.color(color.withOpacity(0.2)).roundedLg.make(),
    );
  }
}
