import 'package:cinema_appp/core/models/genre_model.dart';
import 'package:cinema_appp/pages/movieDetail.dart';
import 'package:flutter/material.dart';
import 'package:cinema_appp/widgets/home/Latest_movies.dart';
import 'package:cinema_appp/services/cinema_api.dart';
import 'package:cinema_appp/services/apiResponse.dart';
import 'package:cinema_appp/core/models/trending_movies.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  final APIResponse<GenreModel> genreList;

  const Home({Key key, this.genreList}) : super(key: key);
  @override
  _HomeState createState() => new _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  //service locator
  CinemaAPI get service => GetIt.I<CinemaAPI>();
  //initializing
  var currentPage = 4 - 1.0;
  bool loading = false;
  int activeId;
  bool loadingPopular = false;
  // ignore: deprecated_member_use
  List<int> trendingIds = new List<int>();
  APIResponse<Trending> _apiResponse;
  APIResponse<Trending> _apiResponsePopular;
  fetchTrending() async {
    setState(() {
      loading = true;
    });

    //API CALL
    _apiResponse = await service.getTrending();
    if (!_apiResponse.error) {
      for (var i = 0; i < 4; i++) {
        setState(() {
          //FETCHING TRENDING MOVIES IDS
          trendingIds.insert(0, _apiResponse.data.results[i].id);
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  fetchPopular() async {
    setState(() {
      loadingPopular = true;
    });

    ///api call
    _apiResponsePopular = await service.getPopularMovies();
    if (!_apiResponsePopular.error) {}
    setState(() {
      loadingPopular = false;
    });
  }

  setActiveId(id) {
    setState(() {
      activeId = id;
    });
  }

  @override
  void initState() {
    fetchTrending();
    fetchPopular();
    super.initState();
  }

  onMovieClicked(index) {
    //check for id size, just to be safe
    if (trendingIds.length >= index)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MovieDetail(id: trendingIds[index]),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 4 - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Center(
            child: Text(
              "Cinema Booking",
              style: TextStyle(
                color: Colors.grey[100],
                fontSize: 25.0,
              ),
            ),
          ),
          leading: Icon(
            Icons.local_movies,
            color: Colors.white,
          ),
          actions: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 10),
            child: Column(
              children: <Widget>[
                loading
                    ? Container(
                        height: 200,
                        //child: Center(child: CircularProgressIndicator()))
                      )
                    : _apiResponse.error
                        ? Container(
                            height: 200,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "sorry something went wrong",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            )),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: "Search Movies",
                                        fillColor: Colors.white54)),
                              ],
                            ),
                          ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Browse Movies",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("Recent Movies",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                loadingPopular
                    ? Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                    : _apiResponsePopular.error
                        ? Container(
                            height: 200,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "sorry something went wrong",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 12.0, bottom: 12.0),
                                  child: InkWell(
                                    onTap: fetchPopular,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Try again",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          )
                        : Container(
                            // wrap in Expanded
                            child: new ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: new List.generate(10, (int index) {
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetail(
                                          id: _apiResponsePopular
                                              .data.results[index].id),
                                    ),
                                  ),
                                  child: PopularMovies(
                                      cardAspectRatio,
                                      _apiResponsePopular.data.results[index],
                                      widget.genreList),
                                );
                              }),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
