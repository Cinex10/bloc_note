
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2,2),
                  blurRadius: 5,
                  // spreadRadius: 4,
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset(
              'assets/images/notebook.png',
              scale: 17,
            ),
          ),
          Column(
            children: [
              GradientText(
                'NoteBooK',
                gradient: LinearGradient(colors: [
                  Colors.blue.shade300,
                  Colors.blue.shade900,
                ]),
                style: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text('by cinex',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 17,
                  // letterSpacing: 3,
                  fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {Key? key, 
    required this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}