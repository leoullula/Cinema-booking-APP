class User {
  final int? id;
  // ignore: non_constant_identifier_names
  final String movie_name;
  final String time;
  final String seat;

  User({
    this.id,
    // ignore: non_constant_identifier_names
    required this.movie_name,
    required this.time,
    required this.seat,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        movie_name = res["movie_name"],
        time = res["time"],
        seat = res["seat"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'movie_name': movie_name,
      'time': time,
      'seat': seat,
    };
  }
}
