import 'package:bloc_note/models/category.dart';
import 'package:flutter/cupertino.dart';

class Task{
  String name;
  bool isCompleted;
  Color color;
  Category? category;

  Task({required this.isCompleted,required this.name,required this.color,this.category});
}