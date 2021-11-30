import 'package:flutter/cupertino.dart';

class Category{
  String nom;
  Color color;
  bool isSelected = false;
  late int nbTsaks = 40;
  late int nbCompletedTasks = 25;

  Category({required this.color,required this.nom,});
}