import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  final VoidCallback? tap;
  final String? text;
  final int? index;
  final double? width;
  final bool? answerState;

  const CandWidget(
      {super.key,
      this.tap,
      this.index,
      this.width,
      this.text,
      this.answerState});
  @override
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width! * 0.8,
      height: widget.width! * 0.1,
      padding: EdgeInsets.fromLTRB(
        widget.width! * 0.024,
        widget.width! * 0.012,
        widget.width! * 0.024,
        widget.width! * 0.012,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrangeAccent),
          color: widget.answerState! ? Colors.deepOrange : Colors.white),
      child: InkWell(
        child: Text(
          widget.text!,
          style: TextStyle(
            fontSize: widget.width! * 0.040,
            color: widget.answerState! ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap!();
            widget.answerState != !widget.answerState!;
          });
        },
      ),
    );
  }
}
