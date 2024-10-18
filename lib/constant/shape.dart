import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rz_test/constant/color_collection.dart';

class RandomShape {
  double randomPosition() {
    return Random().nextInt(11) - 20;
  }

  double randomSize() {
    return Random().nextInt(50) + 120;
  }

  int randomColor() {
    return Random().nextInt(randomColorFromPallate.length);
  }

  List<Color> randomColorFromPallate = [
    ColorApp().indigoGrey,
    ColorApp().celestialBlue,
    ColorApp().lapisLazuli,
    ColorApp().preussianBlue,
  ];

  Positioned randomTopRightCircle() {
    double size = randomSize();
    return Positioned(
      top: randomPosition(),
      right: randomPosition(),
      // right: randomPosition(),
      // left: randomPosition(),
      // bottom: randomPosition(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: randomColorFromPallate[randomColor()],
        ),
      ),
    );
  }

  Positioned randomTopLeftCircle() {
    double size = randomSize();
    return Positioned(
      top: randomPosition(),
      // right: randomPosition(),
      // right: randomPosition(),
      left: randomPosition(),
      // bottom: randomPosition(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: randomColorFromPallate[randomColor()],
        ),
      ),
    );
  }

  Positioned randomTopCenterCircle(BuildContext context) {
    double size = randomSize();
    return Positioned(
      top: randomPosition(),
      // right: randomPosition(),
      // right: randomPosition(),
      left: MediaQuery.of(context).size.width,
      // bottom: randomPosition(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: randomColorFromPallate[randomColor()],
        ),
      ),
    );
  }

  Positioned randomBottomLeftCircle() {
    double size = randomSize();
    return Positioned(
      // top: randomPosition(),
      // right: randomPosition(),
      // right: randomPosition(),
      left: randomPosition(),
      bottom: randomPosition(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: randomColorFromPallate[randomColor()],
        ),
      ),
    );
  }

  Positioned randomBottomRightCircle() {
    double size = randomSize();
    return Positioned(
      // top: randomPosition(),
      // right: randomPosition(),
      right: randomPosition(),
      // left: randomPosition(),
      bottom: randomPosition(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: randomColorFromPallate[randomColor()],
        ),
      ),
    );
  }
}
