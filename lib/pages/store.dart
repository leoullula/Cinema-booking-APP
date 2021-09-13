import 'package:flutter/material.dart';
import 'package:cinema_appp/services db/database_hand.dart';
import 'package:cinema_appp/new db model/user.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppstore extends StatelessWidget {
  // This widget is the root of your application.
  final movie;
  final String selectedSeatsText;
  String schedule = '9:30';

  MyAppstore(this.movie, this.selectedSeatsText, this.schedule);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(movie, selectedSeatsText, schedule),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  final timeg;
  final seatg;
  final dateg;
  MyHomePage(this.dateg, this.timeg, this.seatg);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHandler handler;
  Future<int> addUsers() async {
    User firstUser =
        User(seat: widget.seatg, date: widget.dateg, time: widget.timeg);

    List<User> listOfUsers = [firstUser];
    return await this.handler.insertUser(listOfUsers);
  }

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Store Information List",
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        titleSpacing: 6,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: this.handler.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data[index].id),
                  onDismissed: (DismissDirection direction) async {
                    await this.handler.deleteUser(snapshot.data[index].id);
                    setState(() {
                      snapshot.data.remove(snapshot.data[index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data[index].date),
                    subtitle:
                        Text('Seat Id' + snapshot.data[index].seat.toString()),
                  )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}
