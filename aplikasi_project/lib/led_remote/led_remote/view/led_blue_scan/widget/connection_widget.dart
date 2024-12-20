import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:gap/gap.dart';
import '../../../theme/menu_theme.dart';
import '../../../navigation/head_widget.dart';

class ConnectionWidget extends StatelessWidget {
  const ConnectionWidget({
    super.key,
    required this.bluetoothConnectionState,
  });

  final BluetoothConnectionState bluetoothConnectionState;

  @override
  Widget build(BuildContext context) {
    return bluetoothConnectionState == BluetoothConnectionState.connected
        ? BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.0,
        sigmaY: 1.0,
      ),
      child: Container(
        color: colorBackground!.withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.grey[800]),
              const SizedBox(height: 20),
              // const Gap(headSize),
              const HeadWidget(title: 'Connecting')
            ],
          ),
        ),
      ),
    )
        : const SizedBox.shrink();
  }
}