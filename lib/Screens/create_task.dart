import 'dart:math';
import 'dart:ui';

import 'package:bloc_note/Screens/home.dart';
import 'package:bloc_note/data/categories.dart';
import 'package:bloc_note/data/colors.dart';
import 'package:bloc_note/data/notes.dart';
import 'package:bloc_note/data/tasks.dart';
import 'package:bloc_note/models/category.dart';
import 'package:bloc_note/models/note.dart';
import 'package:bloc_note/models/task.dart';
import 'package:bloc_note/widgets/custom_app_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool isDeleted = true;
  TextEditingController controller = TextEditingController();
  Color selectedColor = Colors.white;
  PageController pageController = PageController();
  int index = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height; 
    int selectedIndex =-1;   
    return Material(
      child: Stack(
        children: [
          CustomAppBar(
            action: RawMaterialButton(
              onPressed: () {
                if (index == 0) {
                  setState(() {
                    index = 1;
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  });
                } else {
                  if ((selectedColor != Colors.white) &
                      (controller.text.isNotEmpty)) {
                    tasks.insert(
                        0,
                        Task(
                            isCompleted: false,
                            color: selectedColor,
                            name: controller.text));
                    index = 0;
                    controller.clear();
                    selectedColor = Colors.white;
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                }
              },
              child: Icon(
                (index == 0)
                    ? Icons.add_circle_outline
                    : Icons.check_circle_outline_rounded,
                size: 30,
                color: Colors.white,
              ),
              shape: const CircleBorder(),
            ),
            leading: RawMaterialButton(
              onPressed: () {
                if (index == 0) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                } else {
                  setState(() {
                    index = 0;
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  });
                }
              },
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
              highlightColor: Colors.white10,
              shape: const CircleBorder(),
            ),
            width: width,
            height: height,
            title: 'TASKS',
          ),
          Positioned(
            top: height * 0.15 - 30,
            child: Container(
              width: width,
              height: height * 0.75 + 30,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) {
                  setState(() {
                    index = i;
                  });
                },
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            for (Category category in categories)
                              CategoryCard(
                                height: height,
                                width: width,
                                category: category,
                              ),
                          ],
                        ),
                      )),
                      Expanded(
                        flex: 3,
                        child: ReorderableListView(
                          header: const Text(
                            'TODAY\'S TASKS',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                          physics: const BouncingScrollPhysics(),
                          onReorder: (oldest, newest) {
                            setState(() {
                              Task tempTask = tasks[oldest];
                              tasks.removeAt(oldest);

                              (oldest > newest)
                                  ? tasks.insert(newest, tempTask)
                                  : tasks.insert(newest - 1, tempTask);
                            });
                          },
                          children: [
                            for (Task task in tasks)
                              Dismissible(
                                key: Key(task.name),
                                dismissThresholds: {
                                  DismissDirection.startToEnd: 0.1,
                                  DismissDirection.endToStart: width,
                                },
                                // movementDuration: const Duration(seconds: 3),
                                // resizeDuration: const Duration(seconds: 4),
                                secondaryBackground: Container(
                                  width: width,
                                  height: 30,
                                  color: Colors.white,
                                ),
                                background: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    key: const Key('deleted'),
                                    children: [
                                      const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.black45,
                                      ),
                                      const Text(
                                        'This task was deleted',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          isDeleted = false;
                                        },
                                        child: const Text(
                                          'UNDO',
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.black12,
                                          primary: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          side: const BorderSide(
                                              color: Colors.black45, width: 3),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                confirmDismiss: (direction) async {
                                  int i = 0;
                                  while ((isDeleted) & (i < 4)) {
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    i++;
                                    if (!isDeleted) break;
                                  }
                                  bool isConfirmed = isDeleted;
                                  isDeleted = true;
                                  return isConfirmed;
                                },
                                onDismissed: (_) {
                                  setState(() {
                                    if (_ == DismissDirection.startToEnd) {
                                      tasks.remove(task);
                                    }
                                  });
                                },
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        task.isCompleted = !task.isCompleted;
                                      });
                                    },
                                    child: Icon(
                                      (task.isCompleted)
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: (task.isCompleted)
                                          ? Colors.grey[400]
                                          : task.color,
                                      size: 30,
                                    ),
                                  ),
                                  key: Key(task.name),
                                  title: Text(
                                    task.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      decoration: (task.isCompleted)
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            labelText: 'Enter task name',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            border: InputBorder.none),
                      ),
                      Wrap(
                        children: [
                          for (Category category in categories)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: (){
                                  print(selectedIndex);
                                setState(() {
                                if(selectedIndex != -1) categories[selectedIndex].isSelected = false;                                
                                  selectedIndex = categories.indexOf(category);                                  
                                  category.isSelected = true;
                                });
                              },
                              child: Chip(
                                elevation: (category.isSelected) ? 10 : 0,                                
                                shadowColor: category.color,
                                  label: Text(
                                    category.nom,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  labelPadding: const EdgeInsets.all(2.0),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.white38,
                                    child: Text(
                                      category.nom[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    radius: 12,
                                  ),
                                  backgroundColor: category.color,
                                ),
                            ),
                          )
                         
                        ],
                      ),
                      Row(
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.black,
                            ),
                            shape: const CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              FontAwesomeIcons.exclamation,
                              color: Colors.black,
                            ),
                            shape: const CircleBorder(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.height,
    required this.width,
    required this.category,
  }) : super(key: key);

  final double height;
  final double width;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height * 0.15,
      width: width * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${category.nbTsaks} tasks',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
          Text(
            category.nom,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          Stack(
            children: [
              Container(
                height: 6,
                width: width * 0.4,
                decoration: BoxDecoration(
                    color: category.color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                height: 6,
                width: width * 0.4 * 0.3,
                decoration: BoxDecoration(
                    color: category.color,
                    boxShadow: [
                      BoxShadow(
                        color: category.color,
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
  double currentProgress;
  Color color;

  CircleProgress({required this.currentProgress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = size.height
      ..color = color.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = size.height
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), outerCircle);
    canvas.drawLine(const Offset(0, 0), Offset(currentProgress * size.width, 0),
        completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
