import 'package:flutter/material.dart';

class Label{
  String title;
  Color color;
  Function onPressed;
  Label({required this.color,required this.title,required this.onPressed});
}