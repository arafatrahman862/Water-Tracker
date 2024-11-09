import 'package:flutter/material.dart';
import 'package:water_track_app/home_screen.dart';

class WatterTrackerApp extends StatelessWidget {
  const WatterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
