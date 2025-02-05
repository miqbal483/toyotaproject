import 'package:flutter/material.dart';
import '../../../constant/pallete_lists.dart';
import '../../../constant/size.dart';
import '../../../navigation/head_widget.dart';

class LedReadyColor extends StatelessWidget {
  const LedReadyColor({
    super.key,
    required this.selectedColor,
  });

  final Function(int) selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadWidget(title: 'Default Colors'),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: hPadding, vertical: vPadding),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async => selectedColor.call(index),
                  child: Container(
                    width: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorList[index].colorName,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}