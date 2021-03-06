import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPimaryColor = Colors.blue;

const kActionColor = Color(0xffF00000);
const kActionColorDisabled = Color(0xffFFCDD2);

const kActionColor1 = Colors.blue;
const kActionColorDisabled1 = Colors.redAccent;

const kBackgroundColor = Color(0xFF1b1e44);
const kMovieNameStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final kMainTextStyle = GoogleFonts.barlow(
    textStyle: TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold));
final kSmallMainTextStyle = kMainTextStyle.copyWith(fontSize: 16.0);

final kPromaryColorTextStyle =
    TextStyle(color: kPimaryColor, fontSize: 18.0, fontWeight: FontWeight.bold);

final BoxDecoration kRoundedFadedBorder = BoxDecoration(
    border: Border.all(color: Colors.white54, width: .5),
    borderRadius: BorderRadius.circular(15.0));

final ThemeData theme =
    ThemeData.dark().copyWith(textTheme: GoogleFonts.barlowTextTheme());
