class User {
  final int id;
  // ignore: non_constant_identifier_names
  final String date;
  final String time;
  final String seat;

  User({
    this.seat,
    this.time,
    this.date,
    this.id,
    // ignore: non_constant_identifier_names
    // required this.movie_name,
    //required this.time,
    //required this.seat,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        date = res["date"],
        time = res["time"],
        seat = res["seat"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'seat': seat,
    };
  }
}

class required {}
