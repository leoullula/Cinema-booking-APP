import 'package:cinema_app/screens/final.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cinema_app/Utils/utils.dart';
//import 'package:firebase_core/firebase_core.dart';

class Confirm extends StatelessWidget {
  final movie;
  final String selectedSeatsText;
  final schedule = '9:30';
  //CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  const Confirm({required this.selectedSeatsText, required this.movie});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${this.movie['original_title']}",
            style: (TextStyle()),
          ),
          elevation: 0,
          //backgroundColor: Colors.transparent,
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
                    Text("Seat ID", style: TextStyle(color: Colors.cyan)),
                    Text(selectedSeatsText,
                        style: TextStyle(color: Colors.cyan))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Schedule",
                              style: TextStyle(color: Colors.cyan)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApps()));
                  },
                ),
              ),
              /*ElevatedButton(
                  child: Text("do"),
                  onPressed: () async {
                    // await Firebase.initializeApp();
                    await users.add({
                      'movie': 'suscide',
                      'schedule': 'suscide',
                      'seat': 'suscide'
                    }).then((value) => print("user added"));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )))),*/
            ],
          ),
        ));
  }
}
