import 'package:cinema_app/screens/confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Seats extends StatefulWidget {
  var time;
  dynamic movie;
  var chosen;
  var seat;
  Seats(
    this.movie,
    this.time,
  ) : super();

  @override
  _SeatsState createState() => new _SeatsState();
}

class _SeatsState extends State<Seats> {
  // ignore: non_constant_identifier_names
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  List<int> _selectedItems = [];
  int price = 30;
  int sum = 0;
  String selectedSeatsText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xff828EFB),
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "${widget.movie['original_title']}",
            style: GoogleFonts.poppins(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          titleSpacing: 6,
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: new Container(
              width: 100.0,
              height: 100.0,
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              image: new DecorationImage(
                  image:
                      new NetworkImage(image_url + widget.movie['poster_path']),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 420,
            width: 350,
            transform: Matrix4.translationValues(5, 15, 1),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(-7, 8), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(45)),
            child: Column(
              children: [
                Container(
                    transform: Matrix4.translationValues(0, 40, 1),
                    child: Text(
                      "Select you seat",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.cyan),
                    )),
                Container(
                  width: 250,
                  transform: Matrix4.translationValues(0, 50, 1),
                  child: Divider(
                    height: 10,
                    color: Colors.cyan,
                    thickness: 3,
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(
                    0,
                    70,
                    0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30),
                    child: GridView.count(
                      crossAxisSpacing: 20,
                      shrinkWrap: true,
                      crossAxisCount: 6,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: List.generate(seats.length, (index) {
                        return Center(
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                if (_selectedItems.contains(index) == false) {
                                  sum = sum + price;
                                  _selectedItems.add(index);
                                  selectedSeatsText = "";
                                  _selectedItems.forEach((element) {
                                    if (selectedSeatsText != "")
                                      selectedSeatsText += " , ";
                                    selectedSeatsText += (seats[element]);
                                  });
                                } else {
                                  sum = sum - price;
                                  _selectedItems.remove(index);
                                  selectedSeatsText = "";
                                  _selectedItems.forEach((element) {
                                    if (selectedSeatsText != "")
                                      selectedSeatsText += " , ";
                                    selectedSeatsText += (seats[element]);
                                  });
                                }
                              });
                            },
                            color: _selectedItems.contains(index)
                                ? Colors.cyan
                                : Colors.grey[300],
                            child: Text(
                              seats[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0, 100, 1),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: Colors.cyan)),
                      color: Colors.white,
                      child: Text(
                        'Ticket Summery',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      onPressed: () {
                        //var DateFormat;
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                              contentPadding:
                                  EdgeInsets.only(bottom: 0, left: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              actions: [
                                FlatButton(
                                  textColor: Colors.pink,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('CLOSE'),
                                )
                              ],
                              insetPadding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 40),
                              title: Text("TicketSummery",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.cyan)),
                              content: Container(
                                width: 100,
                                height: 100,
                                child: ListView(
                                  children: [
                                    Text(
                                        "Movie: " +
                                            "${widget.movie['original_title']}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    /*Text("Time:  " + widget.movie,
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),*/
                                    /*Text(
                                        "Date:  " +
                                            DateFormat.yMd()
                                                .format(widget.chosen),
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),*/
                                    Text(
                                        "Seats:  " +
                                            selectedSeatsText +
                                            "  Price: " +
                                            "$sum",
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              ],
            ),
          ),
          Container(
              transform: Matrix4.translationValues(25, 125, 1),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: Colors.cyan)),
                color: Colors.cyan,
                child: Text(
                  'Generate Ticket',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Confirm(
                      selectedSeatsText: this.selectedSeatsText,
                      movie: this.widget.movie,
                    );
                  }));
                },
              )),
          Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                SizedBox(
                  width: 25,
                  height: 30,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                    ),
                    color: Colors.cyan,
                    onPressed: () {},
                  ),
                ),
                Text("Booked"),
                SizedBox(
                  width: 25,
                  height: 30,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                    ),
                    color: Colors.grey[300],
                    onPressed: () {},
                  ),
                ),
                Text("Available"),
              ]))
        ]));
  }
}

List<String> seats = [
  'A1',
  'A2',
  'A3',
  'A4',
  'A5',
  'B1',
  'B2',
  'B3',
  'B4',
  'B5',
  'C1',
  'C2',
  'C3',
  'C4',
  'D1',
  'D2',
  'D3',
  'D4',
  'D5',
  'E1',
  'E2',
  'E3',
  'E4',
  'E5',
];
