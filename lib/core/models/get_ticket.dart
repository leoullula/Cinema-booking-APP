// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

GetTicket unitFromJson(String str) => GetTicket.fromJson(json.decode(str));

class GetTicket {
  GetTicket(
      {this.title, this.price, this.id, this.seats, this.vseat, this.vid});

  String title;
  String price;
  String id;
  String vid;
  String seats;
  String date;
  String time;
  String vseat;

  GetTicket.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    vid = json['_id'];
    price = json['price'];
    seats = json['seat'];
    vseat = json['seat'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
  }
}
