import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mobile_app/core/constants/app_color.dart';
import '../theme/menu_theme.dart';
import 'ble_off_view.dart';
import 'led_home/led_home_view.dart';

class LEDRemote extends StatefulWidget {
  const LEDRemote({super.key});

  @override
  State<LEDRemote> createState() => _LEDRemoteState();
}

class _LEDRemoteState extends State<LEDRemote> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
          _adapterState = state;
          if (mounted) {
            setState(() {});
          }
        });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = _adapterState == BluetoothAdapterState.on
        ? LEDRemotePage(adapterState: _adapterState)
        : const BleOffPage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambient Light LED Controller'),
        centerTitle: true,
        backgroundColor: TColors.primary20,
      ),
      body: currentPage,
    );
  }
}
