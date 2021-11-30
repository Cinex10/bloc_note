import 'package:bloc_note/Screens/create_note.dart';
import 'package:bloc_note/data/cards.dart';
import 'package:bloc_note/data/notes.dart';
import 'package:bloc_note/models/card.dart';
import 'package:bloc_note/widgets/note_tile.dart';
import 'package:bloc_note/widgets/top_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  CarouselController controller = CarouselController();
  ScrollController scrollController = ScrollController();
  ScrollController labelScrollController = ScrollController();
  String label = 'Today';
  @override
  void initState() {
    _scrollListener() {
      if (scrollController.offset < 150) {
        labelScrollController.animateTo(0,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        labelScrollController.animateTo(
            labelScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear);
      }
    }

    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Hero(
              tag: '33',
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 30),
                width: width,
                height: height * 0.4 + 30,
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          const Spacer(),
                          Expanded(
                            flex: 10,
                            child: TopButton(
                              onPressed: (){
                              },
                              label: 'Note',
                              isActive: true,
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 10,
                            child: TopButton(
                              label: 'Task',
                              onPressed: (){
                                Navigator.pushNamed(context, '/ctask');
                              },
                              isActive: false,
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 10,
                            child: TopButton(
                              onPressed: (){
                                print('object');
                              },
                              label: 'Expenses',
                              isActive: false,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: CarouselSlider.builder(
                        itemCount: cards.length,
                        carouselController: controller,
                        itemBuilder: (context, index, realIndex) {
                          return CustomCard(
                            card: cards[index],
                          );
                        },
                        options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            scrollPhysics: const BouncingScrollPhysics(),
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: cards.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 6,
                          dotWidth: 6,
                          activeDotColor: Colors.white,
                          dotColor: Colors.white.withOpacity(0.3),
                        ),
                        onDotClicked: (i) {
                          setState(() {
                            controller.animateToPage(i);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.4,
            child: Container(
              height: height - (height * 0.4),
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [
                    0.15,
                    0.85,
                  ],
                  colors: [
                    Colors.grey.shade300,
                    Colors.white,
                  ],
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowGlow();
                        return false;
                      },
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 15,
                        ),
                        controller: labelScrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Yesterday',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: [
                            for (var note in notes)                            
                              if(notes.isNotEmpty)  Dismissible(                                
                                secondaryBackground: Container(
                                  padding: const EdgeInsets.only(right: 30),
                                  color: Colors.blue[900],                                    
                                  width: width,
                                  child: const Icon(Icons.delete,color: Colors.white,),
                                  alignment: Alignment.centerRight,
                                ),
                                background: Container(
                                  padding: const EdgeInsets.only(left: 30),
                                  color: Colors.blue[900],                                    
                                  width: width,
                                  child: const Icon(Icons.delete,color: Colors.white,),
                                  alignment: Alignment.centerLeft,
                                ),
                                
                                onDismissed: (direction) {
                                  notes.remove(note);
                                  print(notes.length);
                                },
                                key: Key(note.content),
                                child: NoteTile(
                                  isLast: (note == notes.last),
                                  width: width,
                                  note: note,
                                ),
                              ),
                            const SizedBox(
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        spreadRadius: 20,
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: ClipPath(
                    clipper: Hole(),
                    child: Container(
                      height: height / 10,
                      width: width,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.home,
                            size: 27,
                            color: Colors.blueGrey[800],
                          ),
                          Icon(
                            FontAwesomeIcons.thLarge,
                            size: 27,
                            color: Colors.blueGrey[200],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: (height / 10) * 0.35,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateNoteScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                    highlightElevation: 6,
                    fillColor: Colors.blue[500],
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                    elevation: 30,
                    highlightColor: Colors.blueAccent,
                    splashColor: Colors.white30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            card.name,
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: IconStatistic(
                  number: card.data0,
                  icon: Icons.check_box_outlined,
                ),
              ),
              const Spacer(),
              Container(
                width: 1,
                height: 15,
                color: Colors.white,
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: IconStatistic(
                  number: card.data1,
                  icon: Icons.format_align_center_sharp,
                ),
              ),
              const Spacer(),
              Container(
                width: 1,
                height: 15,
                color: Colors.white,
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: IconStatistic(
                  number: card.data0,
                  icon: Icons.euro,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconStatistic extends StatelessWidget {
  const IconStatistic({
    required this.icon,
    required this.number,
    Key? key,
  }) : super(key: key);
  final int number;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          '$number',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}