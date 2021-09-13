import 'package:cinema_appp/core/helpers/common.dart';
import 'package:cinema_appp/core/models/movie_detail_model.dart';
import 'package:cinema_appp/core/models/schedule_list.dart';
import 'package:cinema_appp/core/models/time_reducer.dart';
import 'package:cinema_appp/pages/buy-ticket.dart';
import 'package:cinema_appp/services/apiResponse.dart';
import 'package:cinema_appp/services/cinema_api.dart';
import 'package:flutter/material.dart';
import 'package:cinema_appp/core/helpers/colors.dart';
import 'package:get_it/get_it.dart';
import './get-geners.dart';
import 'package:cinema_appp/widgets/buy-ticket/calendar-date.dart';

class ContentPage extends StatefulWidget {
  final MovieDetailModel movie;

  const ContentPage({Key key, this.movie}) : super(key: key);
  @override
  _ContentPageState createState() => _ContentPageState();
}

bool loading = false;
CinemaAPI get service => GetIt.I<CinemaAPI>();

APIResponse<List<ScheduleForListing>> _apiResponse;

class _ContentPageState extends State<ContentPage> {
  int activeTime;
  int activeDate;
  int price = 0;
  String currentTime;
  String currentDate;

  List<TimeReducer> dateOfTime = new List<TimeReducer>();

  List<String> initiallySlectedSeats = new List<String>();
  // ignore: deprecated_member_use
  List<String> selectedSeats = new List<String>();
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

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          /* gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)*/
          ),
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 360,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                        "http://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter)),
            ),
            Positioned(
              left: 10,
              top: 15,
              child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 28.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Positioned(
              top: 280,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 8),
                width: _width,
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0xFF1b1e44).withOpacity(0.01),
                    Color(0xFF1b1e44).withOpacity(0.3),
                    Color(0xFF1b1e44).withOpacity(0.6),
                    Color(0xFF1b1e44).withOpacity(0.9),
                    Color(0xFF1b1e44)
                  ],
                )),
              ),
            ),
            Positioned(
              left: 150,
              top: 390,
              child: Container(
                  width: _width - 40,
                  child: new Text(
                    widget.movie.originalTitle,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            Positioned(
                left: 120,
                top: 500,
                child: GetGeners(genres: widget.movie.genres)),
            Positioned(
              left: 20,
              right: 20,
              top: 420,
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 0.5,
                  color: Colors.black38),
            ),
            Positioned(
              top: 390,
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: _width,
                  height: 120,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      widget.movie.runtime.toString(),
                                      style: TextStyle(
                                          color: popularityColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    new Text("Time Duration",
                                        style: TextStyle(color: Colors.black))
                                  ]),
                            ),
                          ),
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: iconColor, size: 28),
                                    RichText(
                                      text: TextSpan(
                                          text: widget.movie.voteAverage
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          children: [
                                            TextSpan(
                                                text: '/ 10',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14))
                                          ]),
                                    )
                                  ]),
                            ),
                          ),
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      widget.movie.popularity.toString(),
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    new Text("View",
                                        style: TextStyle(color: Colors.black))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(
              left: 20,
              right: 5,
              top: 550,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          new Text('Synopsis',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: new Text(widget.movie.overview,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Theme.of(context).buttonTheme.height + 20,
                width: double.infinity,
                child: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('Continue to seat selector ',
                            style: TextStyle(fontSize: 18)),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BuyTicket(
                          title: widget.movie.originalTitle.toString()),
                    ),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
