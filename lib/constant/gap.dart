import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GapCollection {
  static SizedBox gap = const SizedBox(
    height: 10,
  );

  static Gap(double heigth) {
    return SizedBox(
      height: heigth,
    );
  }

  static TextStyle inputlabel = const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);
}
