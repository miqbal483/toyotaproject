import 'package:flutter/material.dart';
import 'package:mobile_app/core/constants/app_color.dart';
import '../constant/size.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hPadding),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: headSize,
          color: Colors.white,
        ),
      ),
    );
  }
}