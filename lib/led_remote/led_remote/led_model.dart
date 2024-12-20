import 'package:flutter/material.dart';

// Ini model untuk transmisi data
class LedModel {
  late bool isLedOn;
  late int brightnessValue, selectedAnimation, ledRed, ledGreen, ledBlue;

  LedModel(
      {required this.isLedOn,
        required this.brightnessValue,
        required this.selectedAnimation,
        required this.ledRed,
        required this.ledGreen,
        required this.ledBlue});
}

// Ini model untuk warna RGB
class RgbModel {
  late Color colorName;
  late int red, green, blue;

  RgbModel({
    required this.colorName,
    required this.red,
    required this.green,
    required this.blue,
  });
}