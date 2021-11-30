import 'package:bloc_note/data/labels.dart';
import 'package:bloc_note/models/label.dart';
import 'package:bloc_note/models/note.dart';
import 'package:flutter/material.dart';


class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.width,
    required this.note,
    required this.isLast,
  }) : super(key: key);

  final double width;
  final Note note;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 25,
      ),
      height: 130,
      width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: (isLast) ? null : const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.3,
            ),
          ),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              note.title,
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w700,
                fontSize: 19,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              note.content,
              maxLines: 2,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var index in note.labels)
                  LabelButton(
                    label: labels[index],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LabelButton extends StatelessWidget {
  const LabelButton({
    required this.label,
    Key? key,
  }) : super(key: key);

  final Label label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      highlightElevation: 0,
      splashColor: label.color.withOpacity(0.15),
      highlightColor: label.color.withOpacity(0.15),
      color: label.color.withOpacity(0.15),
      elevation: 0,
      height: 27,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.title,
        style: TextStyle(
          color: label.color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
