import 'package:cinema_appp/new%20db%20model/user.dart';
import 'package:cinema_appp/pages/cinema-ticket.dart';
import 'package:cinema_appp/services/apiResponse.dart';
import 'package:cinema_appp/widgets/buy-ticket/const.dart';
import 'package:flutter/material.dart';
import 'package:cinema_appp/widgets/buy-ticket/calendar-date.dart';
import 'package:cinema_appp/widgets/buy-ticket/cinema-seat.dart';
import 'package:cinema_appp/widgets/buy-ticket/show-time.dart';

import 'package:cinema_appp/services/cinema_api.dart';
import 'package:cinema_appp/core/models/schedule_list.dart';
import 'package:cinema_appp/core/models/time_reducer.dart';
import 'package:cinema_appp/core/models/create_ticket.dart';
import 'package:get_it/get_it.dart';
import 'package:cinema_appp/core/helpers/common.dart';

///this page includes the detail implementation
/// of the ticket buying logic
class BuyTicket extends StatefulWidget {
  // var title;
  final String title;

  const BuyTicket({Key key, this.title}) : super(key: key);
  // BuyTicket({String title});
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int activeTime;
  int activeDate;
  final int yMax = 3;
  final int xMax = 9;

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  final int v_yMax = 3;
  // ignore: non_constant_identifier_names
  final int v_xMax = 8;
  final int ticketPrice = 80;
  // ignore: non_constant_identifier_names
  final int vip_ticketPrice = 500;
  int price = 0;
  int QTY = 0;
  String currentTime;
  String currentDate;
  // ignore: deprecated_member_use
  List<String> selectedSeats = new List<String>();

  // ignore: non_constant_identifier_names
  List<String> v_selectedSeats = new List<String>();
  // ignore: deprecated_member_use
  List<String> initiallySlectedSeats = new List<String>();

  // ignore: deprecated_member_use
  List<String> v_initiallySlectedSeats = new List<String>();
  bool buying = false;

  // ignore: deprecated_member_use
  List<TimeReducer> dateOfTime = new List<TimeReducer>();

//set active time on click
  setActiveTime(i, time) {
    List<TimeReducer> selectedTime =
        dateOfTime.where((i) => i.time == time).toList();

    setState(() {
      activeTime = i;
      initiallySlectedSeats = selectedTime[0].reserved;
      selectedSeats = []; //reset selected
      currentTime = time;
    });
  }

  //set active time on click
  vsetActiveTime(i, time) {
    List<TimeReducer> vselectedTime =
        dateOfTime.where((i) => i.time == time).toList();

    setState(() {
      activeTime = i;
      v_initiallySlectedSeats = vselectedTime[0].reserved;
      v_selectedSeats = []; //reset selected
      currentTime = time;
    });
  }

//set active date on calendar click
  setActiveDate(i, date) {
    List<ScheduleForListing> res =
        _apiResponse.data.where((i) => i.date == date).toList();
    setState(() {
      activeDate = i;
      dateOfTime = res[0].times; //filtering times from selected date
      activeTime = 0; // reset active time postition
      initiallySlectedSeats = res[0]
          .times[0]
          .reserved; //set the initaial reserved seats for the initial time
      selectedSeats = []; //reset selected
      price = 0; //reset price

      currentDate = date;
    });
  }

  //set active date on calendar click
  vsetActiveDate(i, date) {
    List<ScheduleForListing> res =
        _apiResponse.data.where((i) => i.date == date).toList();
    setState(() {
      activeDate = i;
      dateOfTime = res[0].times; //filtering times from selected date
      activeTime = 0; // reset active time postition
      v_initiallySlectedSeats = res[0]
          .times[0]
          .reserved; //set the initaial reserved seats for the initial time
      v_selectedSeats = []; //reset selected
      price = 0; //reset price

      currentDate = date;
    });
  }

//action on seat cliecked
  onSeatClicked(String i) {
    //check if seat is not initially selected
    if (!initiallySlectedSeats.contains(i)) {
      //if this is a check
      if (!selectedSeats.contains(i)) {
        setState(() {
          selectedSeats.add(i);
          price += ticketPrice;
          QTY = selectedSeats.length;

          // increase price
        });
      } else {
        //remove
        setState(() {
          selectedSeats.removeWhere((item) => item == i);
          //decrease price
          price -= ticketPrice;
          QTY = selectedSeats.length;
        });
      }
      print(selectedSeats);
    }
  }

  // ignore: non_constant_identifier_names
  vip_onSeatClicked(String k) {
    //check if seat is not initially selected

    if (!initiallySlectedSeats.contains(k)) {
      //if this is a check
      if (!v_selectedSeats.contains(k)) {
        setState(() {
          v_selectedSeats.add(k);
          price += vip_ticketPrice;
          QTY = v_selectedSeats.length;
          // increase price
        });
      } else {
        //remove
        setState(() {
          v_selectedSeats.removeWhere((item) => item == k);
          //decrease price
          price -= vip_ticketPrice;
          QTY = v_selectedSeats.length;
        });
      }
      print(v_selectedSeats);
    }
  }

  bool loading = false;
  CinemaAPI get service => GetIt.I<CinemaAPI>();

  APIResponse<List<ScheduleForListing>> _apiResponse;

  fetchSchedules() async {
    setState(() {
      loading = true;
    });

//API CALLING
    _apiResponse = await service.getSchedules();
    if (!_apiResponse.error) {
      var res = _apiResponse.data[0];
      setState(() {
        dateOfTime = res.times; //filtering times from selected date
        activeTime = 0; // reset active time postition
        initiallySlectedSeats = res.times[0]
            .reserved; //set initial selected state to the first element
        currentDate = res.date;
        currentTime = res.times[0].time;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    //set top items as initial data

    fetchSchedules();
    setState(() {
      activeTime = 0;
      activeDate = 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Builder(builder: (_) {
          if (loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (_apiResponse.error) {
            print(_apiResponse.errorMessage);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "sorry something went wrong",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 12.0, bottom: 12.0),
                  child: InkWell(
                    onTap: fetchSchedules,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text("Try again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ));
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                    Center(
                        child: Column(
                      children: [
                        Text("Select Schedule",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                        SizedBox(height: 10),
                        Text(
                            "${getDateStringAndDate(currentDate)} | $currentTime",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        const Divider(
                          height: 20,
                          thickness: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SizedBox(height: 6),
                      ],
                    )),
                    //Center(child: Image.asset('assets/screen.png')),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: getCinemaSeats(),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                circle(
                                  Colors.white,
                                ),
                                Text("Available",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                            Column(
                              children: [
                                circle(Colors.grey),
                                Text("Reserved",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                            Column(
                              children: [
                                circle(kPimaryColor),
                                Text("Selected",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Center(
                      child: Text("VIP Seats",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children:

                            //loop on y axis

                            vip_getCinemaSeats(),
                      ),
                    ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                circle(
                                  Colors.white,
                                ),
                                Text("Available",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                            Column(
                              children: [
                                circle(Colors.red),
                                Text("Reserved",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                            Column(
                              children: [
                                circle(Colors.green),
                                Text("Selected",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Center(
                      child: Text("Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                for (var i = 0;
                                    i < _apiResponse.data.length;
                                    i++)
                                  CalendarDay(
                                      monthAbr: getMonthString(
                                          _apiResponse.data[i].date),
                                      dayNumber:
                                          getDateNum(_apiResponse.data[i].date),
                                      dayAbbreviation: getDateString(
                                          _apiResponse.data[i].date),
                                      position: i,
                                      isActive: activeDate == i,
                                      date: _apiResponse.data[i].date,
                                      setActiveDate: setActiveDate),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Center(
                      child: Text("Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < dateOfTime.length; i++)
                            ShowTime(
                                time: dateOfTime[i].time,
                                price: 10,
                                isActive: i == activeTime,
                                availability: dateOfTime[i].availability,
                                possition: i,
                                setActiveTime: setActiveTime),
                          const Divider(
                            height: 20,
                            thickness: 5,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Center(
                            child: Text("Payment",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: MyApppay(this.price))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            '$QTY QTY',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            '$price Total',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 110.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: price == 0 || buying
                              ? kActionColorDisabled1
                              : kActionColor1,
                          borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(25.0)
                              )),
                      child: InkWell(
                          onTap: onGetTicket,
                          child: Text(
                              buying ? "processing..." : 'Generate ticket',
                              style: TextStyle(
                                  color: price == 0 || buying
                                      ? Colors.black45
                                      : Colors.white,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold))),
                    ),
                    /* Container(
                      height: Theme.of(context).buttonTheme.height + 10,
                      width: double.infinity,
                      child: new RaisedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save),
                            new Text(
                                loading ? "Please wait..." : "Pay and Activate",
                                style: new TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        colorBrightness: Brightness.dark,
                        //onPressed: !loading ? () => _capturePng(context) : () {},
                        color: Colors.blue,
                      ),
                    ),*/
                  ]),
                ),

                ///here close thingy
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> getCinemaSeats() {
    // ignore: deprecated_member_use
    List<Widget> verticalList = new List<Widget>();
    for (int i = 0; i < yMax; i++) {
      verticalList.add(getHorzontalList(i));
    }
    return verticalList;
  }

  // ignore: non_constant_identifier_names
  List<Widget> vip_getCinemaSeats() {
    // ignore: deprecated_member_use
    List<Widget> vVerticalList = new List<Widget>();
    for (int vi = 10; vi < v_yMax + 10; vi++) {
      vVerticalList.add(vip_getHorzontalList(vi));
    }
    return vVerticalList;
  }

  Widget getHorzontalList(int position) {
    int y = 0;
    // ignore: deprecated_member_use
    List<Widget> horizontalList = new List<Widget>();
    if (position != yMax)
      horizontalList.add(Text("${String.fromCharCode(position + 65)}",
          style: TextStyle(color: Colors.black)));
    //replacing corner items with empty spaces
    for (int j = 0; j < xMax; j++) {
      //get horizontal lables
      if (position == yMax) {
        if (j != (xMax / 2).floor()) {
          y++;

          horizontalList.add(Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
            width: MediaQuery.of(context).size.width / 15,
            height: MediaQuery.of(context).size.width / 15,
            child: Text("$y",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                )),
          ));
        } else {
          horizontalList.add(SizedBox(
            width: (MediaQuery.of(context).size.width / 20) * 2,
          ));
        }
        continue;
      }
      if (j == 0 && position == 0 ||
          j == xMax - 1 && position == 0 ||
          j == 0 && position == yMax - 1 ||
          j == xMax - 1 && position == yMax - 1 ||
          j == (xMax / 2).floor()) {
        horizontalList.add(SizedBox(
          width: (MediaQuery.of(context).size.width / 240),
        ));
      } else {
        String id = '${String.fromCharCode(position + 65)}${j + 1}';
        horizontalList.add(CienmaSeat(
            onSeatClicked: onSeatClicked,
            isSelected: selectedSeats.contains(id),
            isReserved: initiallySlectedSeats.contains(id),
            id: id));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: horizontalList);
  }

  // ignore: non_constant_identifier_names
  Widget vip_getHorzontalList(int v_position) {
    int vY = 0;
    // ignore: deprecated_member_use
    List<Widget> vHorizontalList = new List<Widget>();
    if (v_position != v_yMax)
      vHorizontalList.add(Text("${String.fromCharCode(v_position + 70)}",
          style: TextStyle(color: Colors.black)));
    //replacing corner items with empty spaces
    for (int vj = 0; vj < v_xMax; vj++) {
      //get horizontal lables
      if (v_position == v_yMax) {
        if (vj != (v_xMax / 2).floor()) {
          vY++;

          vHorizontalList.add(Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
            width: MediaQuery.of(context).size.width / 15,
            height: MediaQuery.of(context).size.width / 15,
            child: Text("$vY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                )),
          ));
        } else {
          vHorizontalList.add(SizedBox(
            width: (MediaQuery.of(context).size.width / 20) * 2,
          ));
        }
        continue;
      }
      if (vj == 0 && v_position == 0 ||
          vj == v_xMax - 1 && v_position == 0 ||
          vj == 0 && v_position == v_yMax - 1 ||
          vj == v_xMax - 1 && v_position == v_yMax - 1 ||
          vj == (v_xMax / 2).floor()) {
        vHorizontalList.add(SizedBox(
          width: (MediaQuery.of(context).size.width / 240),
        ));
      } else {
        // ignore: non_constant_identifier_names
        String vid = '${String.fromCharCode(v_position + 65)}${vj + 1}';
        vHorizontalList.add(V_CienmaSeat(
            vip_onSeatClicked: vip_onSeatClicked,
            visSelected: v_selectedSeats.contains(vid),
            visReserved: initiallySlectedSeats.contains(vid),
            vid: vid));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: vHorizontalList);
  }

  buildAppBar() {
    return AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        leading: Container(
          width: MediaQuery.of(context).size.width * .12,
          height: MediaQuery.of(context).size.width * .12,
          child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 28.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ));
  }

//store ticket on database
  onGetTicket() async {
    if (price != 0 || !buying) {
      setState(() {
        buying = true;
      });
      final ticket = TicketCrate(
        price: '$price',
        title: widget.title,
        seat: selectedSeats + v_selectedSeats,
      );

      final result =
          await service.createTicket(ticket, currentDate, currentTime);

      setState(() {
        buying = false;
      });
      print(result.errorMessage);
      if (!result.error) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QRTicket(ticket: result.data),
          ),
        );
      }
    }
  }

  Widget circle(color) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
        width: MediaQuery.of(context).size.width / 15,
        height: MediaQuery.of(context).size.width / 15,
        decoration: BoxDecoration(
          border: color == Colors.cyan
              ? Border.all(color: Colors.black, width: 1.0)
              : Border.all(color: Colors.black, width: 1.0),
          color: color,
          shape: BoxShape.circle,
        ));
  }
}

class MyApppay extends StatelessWidget {
  int price;
  MyApppay(this.price);

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MyCustomForm();
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int price = 500;
    TextEditingController paidController = new TextEditingController();

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue[500],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 300,
      width: 300,
      child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Form",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue),
                      ),
                      Icon(
                        Icons.credit_card,
                        color: Colors.blue,
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Card Number',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: paidController,
                  decoration: new InputDecoration(
                    hintText: 'Ticket Amount',
                  ),
                  // The validat
                  //or receives the text that the user has entered.
                  validator: (value) {
                    // ignore: unrelated_type_equality_checks
                    if (paidController.text == '$price') {
                      return 'paid';
                    }
                    return 'Please enter correct amount';
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // TODO submit
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          )),
    );
  }
}
