import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:mortgage_calculator/screens/screens.dart';
import 'package:mortgage_calculator/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome Mortgage Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: primaryColor.withOpacity(0.15),
          primaryColorDark: secondaryColor.withOpacity(0.15),
          primaryColorLight: Colors.white70.withOpacity(0.15),
          valueIndicatorTextStyle: TextStyle(
            fontSize: 10,
            color: inactive,
          ),
        ),
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
        ),
        canvasColor: secondaryColor,
      ),
      home: HomeScreen(),
    );
  }
}
