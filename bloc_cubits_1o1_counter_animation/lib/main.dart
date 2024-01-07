import 'package:bloc_cubits_1o1_counter_animation/UI/counter_screen/counter_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PlayPauseAnimation(),
    ),
  );
}
