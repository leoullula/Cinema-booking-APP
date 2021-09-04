import 'package:cinema_app/screens/store.dart';
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:cinema_app/Utils/utils.dart';

class Confirm extends StatelessWidget {
  final Color mainColor = const Color(0xff3C3261);
  final movie;
  final String selectedSeatsText;
  final schedule = '9:30';

  @override
  const Confirm({required this.selectedSeatsText, required this.movie});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white12,
          title: Text(
            this.movie['original_title'],
            style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 6,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Cinema Ticket", style: MainHeading),
              // Text(this.movieName, style: BasicHeading),
              Center(
                child: QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    Text("Seat ID",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(selectedSeatsText,
                        style: TextStyle(color: Colors.blue))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Schedule",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("To-Day" + schedule,
                              style: TextStyle(color: Colors.cyan))
                        ],
                      ),
                    ]),
              ]),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                height: 50,
                child: RaisedButton(
                  child: Text("Generate Data",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                  color: Colors.cyan,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp(movie, selectedSeatsText, schedule)));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
