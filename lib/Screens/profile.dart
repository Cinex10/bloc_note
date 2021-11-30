import 'dart:math';
import 'dart:ui';

import 'package:bloc_note/widgets/bar_chart.dart';
import 'package:bloc_note/data/labels.dart';
import 'package:bloc_note/data/notes.dart';

import 'package:bloc_note/widgets/label_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingBarGroups = [];
  List<BarChartGroupData> rawBarGroups = [];
  int touchedGroupIndex = -1;
  var items;
  @override
  void initState() {
    items = [
      makeGroupData(0, 5, 12),
      makeGroupData(1, 16, 12),
      makeGroupData(2, 18, 5),
      makeGroupData(3, 20, 16),
      makeGroupData(4, 17, 6),
      makeGroupData(5, 19, 1.5),
      makeGroupData(6, 10, 1.5),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 40,
              ),
              width: width,
              height: height * 0.26,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [
                    0.3,
                    0.9,
                  ],
                  colors: [
                    const Color(0xFF0794FE),
                    const Color(0xFF0794FE).withOpacity(0.6),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'AYacine DR',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '7 Octobr 2019',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0PR2ZAzwhWY7orX3aNxJE67X5TaAjAN7H_g&usqp=CAU'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white10,
                      shadowColor: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Row(
                      children: const [
                        Spacer(
                          flex: 4,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          'Search your item',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                          ),
                        ),
                        Spacer(
                          flex: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                height: height * 0.74,
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      30,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 15,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Labels',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blueGrey[800],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Manage',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int label = 0;
                                    label < labels.length ~/ 4;
                                    label++)
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        for (int rowLabel = label * 4;
                                            rowLabel <
                                                min((label + 1) * 4,
                                                    labels.length);
                                            rowLabel++)
                                          LabelButton(
                                            label: labels[rowLabel],
                                          ),
                                      ],
                                    ),
                                  ),
                                if (labels.length % 4 != 0) Expanded(
                                  child: Row(
                                    children: [
                                      for (int rowLabel =
                                              4 * (labels.length ~/ 4);
                                          rowLabel < labels.length;
                                          rowLabel++)
                                        LabelButton(
                                          label: labels[rowLabel],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              'Activity',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              '21 completed tasks',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2,),
                    Expanded(
                      flex: 23,
                      child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3)),
                            ],
                          ),
                          child: const BarChartSample1(
                            values: [8, 6, 4, 6, 3, 9, 18],
                          )),
                    ),
                    const Spacer(flex: 2,),
                    Expanded(
                      flex: 16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Your monthly record of doing the task',
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:  [
                                        Text('43/90  Task done',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey[800],
                                        ),),
                                         Text('🔵 Today record',style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey[200],
                                        ),),
                                         Text('⚪ Average monthly record',style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey[200],
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomPaint(
                                      painter: CircleProgress(
                                      43,
                                      ),
                                      child:  SizedBox(
                                        height: 100, 
                                        child: Center(child: Text('43%',style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey[800],
                                        ),),),                                       
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleProgress extends CustomPainter{

  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {

    //this is base circle
    Paint outerCircle = Paint()
        ..strokeWidth = 10
        ..color = Colors.blue.shade50
        ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}


class Hole extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.4 - 35, 0);
    path.quadraticBezierTo(
      size.width * 0.4 - 10,
      -3,
      size.width * 0.4 - 7,
      20,
    );
    path.quadraticBezierTo(
      size.width * 0.4,
      65,
      size.width * 0.5,
      65,
    );
    path.quadraticBezierTo(
      size.width * 0.6,
      65,
      size.width * 0.6 + 7,
      20,
    );
    path.quadraticBezierTo(
      size.width * 0.6 + 10,
      -3,
      size.width * 0.6 + 35,
      0,
    );

    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    path.fillType = PathFillType.nonZero;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 25,
      ),
      height: 150,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              notes.first.title,
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              notes.first.content,
              maxLines: 2,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LabelButton(
                  label: labels[0],
                ),
                LabelButton(
                  label: labels[1],
                ),
                LabelButton(
                  label: labels[2],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
