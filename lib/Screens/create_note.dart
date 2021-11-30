import 'dart:ui';

import 'package:bloc_note/Screens/home.dart';
import 'package:bloc_note/data/notes.dart';
import 'package:bloc_note/models/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              width: width,
              height: height * 0.13,
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
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    shape: const CircleBorder(),
                  ),
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white54,
                      cursorWidth: 4,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {if (contentController
                          .text.isNotEmpty) {
                        notes.add(Note(
                            content: contentController.text,
                            title: titleController.text,
                            date: '',
                            labels: [0, 1, 2]));
                      }}
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.white,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              top: height * 0.13 - 30,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 35,
                ),
                height: height - (height * 0.13 - 30) - (height * 0.45),
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: TextField(
                  controller: contentController,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  scrollPhysics: const BouncingScrollPhysics(),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    hintText: 'Start writing your note',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height - (height * 0.13 - 30) - (height * 0.45),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                height: (height * 0.5138),
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Font Size',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black38,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Small',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: const Border.symmetric(
                                horizontal: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                vertical: BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Medium',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black38,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Large',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Font Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                     Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_bold,
                              color: Colors.black26,
                              size: 40,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_italic,
                              color: Colors.black26,
                              size: 40,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.format_strikethrough_sharp,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_underline,
                              color: Colors.black26,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_list_numbered_outlined,
                              color: Colors.black26,
                              size: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_list_bulleted_sharp,
                              color: Colors.black26,
                              size: 40,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_align_left_rounded,
                              size: 40,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: const Border.symmetric(
                                horizontal: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                vertical: BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.format_align_center_sharp,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.format_align_right_rounded,
                              size: 40,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




