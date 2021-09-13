// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

String unitToJson(TicketCrate data) => json.encode(data.toJson());

class TicketCrate {
  TicketCrate({this.title, this.price, this.seat, this.vseat});

  String title;
  String price;
  List<String> seat;
  List<String> vseat;

  Map<String, dynamic> toJson() =>
      {"title": title, "price": price, "seat": seat, "vseat": vseat};
}
