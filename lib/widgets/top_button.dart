import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton({
    Key? key,
    required this.isActive,
    required this.label,
    required this.onPressed,
    
  }) : super(key: key);
  final bool isActive;
  final String label;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
            color: (isActive) ? Colors.blue : Colors.white,
            fontWeight: FontWeight.w900),
      ),
      style: ElevatedButton.styleFrom(
        onSurface: Colors.red,
        onPrimary: (isActive) ? Colors.blue.shade300 : Colors.white,
        primary: (isActive) ? Colors.white : Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,        
        side: BorderSide(
          color: Colors.white.withOpacity((isActive) ? 0 : 0.4),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
