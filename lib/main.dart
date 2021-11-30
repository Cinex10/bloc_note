
import 'package:bloc_note/Screens/create_note.dart';
import 'package:bloc_note/Screens/create_task.dart';
import 'package:bloc_note/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor: Colors.black12, // status bar color
    statusBarBrightness: Brightness.light,    
  ));
  runApp(
    MaterialApp(
      routes: {
        '/' : (context) => const HomeScreen(),
        '/cnote' : (context) => const CreateNoteScreen(),
        '/ctask' : (context) => const CreateTaskScreen(),
      },
      initialRoute:'/',
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}


