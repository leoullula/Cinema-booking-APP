import 'package:flutter/material.dart';

import './const.dart';

// ignore: must_be_immutable
class CienmaSeat extends StatefulWidget {
  bool isReserved;
  final String id;
  bool isSelected;
  final onSeatClicked;

  CienmaSeat({
    this.isSelected,
    this.isReserved,
    this.id,
    this.onSeatClicked,
  });

  @override
  _CienmaSeatState createState() => _CienmaSeatState();
}

class _CienmaSeatState extends State<CienmaSeat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.onSeatClicked(widget.id);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? kPimaryColor
                  : widget.isReserved
                      ? Colors.grey
                      : null,
              border: !widget.isSelected && !widget.isReserved
                  ? Border.all(color: Colors.black, width: 1.0)
                  : null,
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}

class V_CienmaSeat extends StatefulWidget {
  bool visReserved;
  final String vid;
  bool visSelected;
  final vip_onSeatClicked;
  V_CienmaSeat(
      {
      // ignore: non_constant_identifier_names
      this.vip_onSeatClicked,
      this.vid,
      this.visReserved,
      this.visSelected});

  @override
  V_CienmaSeatState createState() => V_CienmaSeatState();
}

// ignore: camel_case_types
class V_CienmaSeatState extends State<V_CienmaSeat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.vip_onSeatClicked(widget.vid);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: widget.visSelected
                  ? Colors.green
                  : widget.visReserved
                      ? Colors.red
                      : null,
              border: !widget.visSelected && !widget.visReserved
                  ? Border.all(color: Colors.black, width: 1.0)
                  : null,
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
