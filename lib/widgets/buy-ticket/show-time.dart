import 'package:flutter/material.dart';

import './const.dart';

// ignore: must_be_immutable
class ShowTime extends StatefulWidget {
  bool isActive;
  final int possition;
  final int price;
  final availability;
  final setActiveTime;
  final String time;

  ShowTime(
      {@required this.time,
      @required this.price,
      @required this.possition,
      this.isActive = false,
      this.setActiveTime,
      this.availability});

  @override
  _ShowTimeState createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        widget.setActiveTime(widget.possition, widget.time);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: widget.isActive ? kPimaryColor : Colors.grey[200],
            border: Border.all(
                color: widget.isActive ? kPimaryColor : Colors.white12),
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
            Text(
              widget.time,
              style: TextStyle(
                  color: widget.isActive ? kPimaryColor : Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text(
                widget.availability == 'available'
                    ? '(Available)'
                    : 'Not-Available',
                style: TextStyle(
                    color: widget.availability == 'available'
                        ? Colors.black
                        : Colors.red,
                    fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}
