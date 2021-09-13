import 'package:flutter/material.dart';

class Activate extends StatelessWidget {
  const Activate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [], title: Text("Pay and Activate ticket")),
      body: Container(
        child: Center(
          child: Text("Payment",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black)),
        ),
        /*  Padding(
                              padding: EdgeInsets.all(5.0),
                              child: MyApppay(this.price))*/
      ),
    );
  }
}
