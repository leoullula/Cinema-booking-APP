import 'package:flutter/material.dart';
import 'package:cinema_app/seat_selector/newseat.dart';

// ignore: camel_case_types
class Movie_Detail extends StatefulWidget {
  final movie;

  Movie_Detail(this.movie);

  @override
  _Movie_DetailState createState() => _Movie_DetailState();
}

// ignore: camel_case_types
class _Movie_DetailState extends State<Movie_Detail> {
  var time;

  bool pressGeoON = false;

  bool cmbscritta = false;

  // ignore: non_constant_identifier_names
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie['title'],
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100.0,
                    height: 400.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              image_url + widget.movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: Row(
                    children: <Widget>[
                      Center(
                          child: Text(
                        widget.movie['title'],
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.0,
                            fontFamily: 'Arvo'),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                    Text(
                      '${widget.movie['vote_average']}/10',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Arvo'),
                    ),
                    SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                    SizedBox(width: 20),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        )),
                  ],
                ),
                Container(
                  width: 350,
                  transform: Matrix4.translationValues(0, 20, 1),
                  child: Divider(
                    height: 10,
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                ),
                SizedBox(height: 30),
                Text("Synopsis",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(widget.movie['overview'],
                    style: TextStyle(color: Colors.grey, fontFamily: 'Arvo')),
                Container(
                  width: 350,
                  transform: Matrix4.translationValues(0, 20, 1),
                  child: Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                SizedBox(height: 40),
                Text("Schedule List",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold)),
                Padding(padding: const EdgeInsets.all(10.0)),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: pressGeoON ? Colors.red : Colors.white,

                  textColor: Colors.white,
                  child: cmbscritta
                      ? Text(
                          "Schedule Booked",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text("09:30 (Available)",
                          style: TextStyle(color: Colors.black)),
                  //    style: TextStyle(fontSize: 14)

                  onPressed: () {
                    setState(() => pressGeoON = !pressGeoON);
                    setState(() => cmbscritta = !cmbscritta);
                  },
                ),
                ElevatedButton(
                    child: cmbscritta
                        ? Text("6:30 Not Available")
                        : Text("6:30 Not Available"),
                    //    style: TextStyle(fontSize: 14)

                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )))),
                ElevatedButton(
                    child: cmbscritta
                        ? Text("12:30 Not Available")
                        : Text("12:30 Not Available"),
                    //    style: TextStyle(fontSize: 14)

                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )))),
                ElevatedButton(
                    child: cmbscritta
                        ? Text("1:30 Not Available")
                        : Text("1:30 Not Available"),
                    //    style: TextStyle(fontSize: 14)

                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )))),
                SizedBox(height: 40),
                ElevatedButton(
                    child: Text('Continue to seat selector'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Seats(this.widget.movie, this.time)));
                    }),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
