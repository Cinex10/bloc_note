import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.width,
    required this.title,
    required this.action,
    required this.leading,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final String title;
  final Widget leading;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 1,
      child: Container(
        width: width,
        height: height * 0.15,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.4,
              0.98,
            ],
            colors: [
              Color(0xFF0794FE),
              Color(0xB050BFFD),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
             Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            action,
          ],
        ),
      ),
    );
  }
}
