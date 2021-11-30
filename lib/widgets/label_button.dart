import 'package:bloc_note/models/label.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
    required this.label,
    Key? key,
  }) : super(key: key);

  final Label label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      highlightElevation: 0,
      splashColor: label.color.withOpacity(0.15),
      highlightColor: label.color.withOpacity(0.15),
      color: label.color.withOpacity(0.15),
      elevation: 0,
      height: 27,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.title,
        style: TextStyle(
          color: label.color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}