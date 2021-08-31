import 'package:flutter/material.dart';
import 'package:cinema_app/screens/movi_list.dart';

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies Sample',
      home: MovieList(),
    );
  }
}
