import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  final List<double> values;

  const BarChartSample1({Key? key,required this.values}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),    
      swapAnimationDuration: animDuration,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 14,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [        
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.blue.shade400] : [Colors.blue.shade900,Colors.blue.shade200,],
          width: 11,                    
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.grey.shade200],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
  

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {        
            return makeGroupData(i, widget.values[i], isTouched: i == touchedIndex);              
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        allowTouchBarBackDraw: true,
        touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 20,
            tooltipBgColor: Colors.blue.shade400,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              try {
                weekDay = days[group.x.toInt()];                                
              } on Exception catch (e) {
                weekDay = '?';
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) =>  TextStyle(
              color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
           
           try {
             return days[value.toInt()][0];
           } on Exception catch (e) {
            return '?';
           }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

 

  }
