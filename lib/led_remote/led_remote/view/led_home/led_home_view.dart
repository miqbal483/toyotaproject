import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mobile_app/core/constants/app_color.dart';
import 'widget/led_animation_widget.dart';
import 'widget/led_brighness_widget.dart';
import 'widget/led_colorpicker_widget.dart';
import 'widget/led_preset_widget.dart';
import 'widget/led_status_widget.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gap/gap.dart';
import '../../constant/ble_constant.dart';
import '../../constant/pallete_lists.dart';
import '../../hexdecimalconv/hex_dec_converter.dart';
import '../../led_model.dart';
import '../../view/led_blue_scan/scan_menu.dart';

class LEDRemotePage extends StatefulWidget {
  const LEDRemotePage({super.key, required this.adapterState});

  final BluetoothAdapterState adapterState;

  @override
  State<LEDRemotePage> createState() => _LEDRemotePageState();
}

class _LEDRemotePageState extends State<LEDRemotePage> {
  late bool _isScanning;
  late int _selectedDeviceIndex;
  late LedModel _ledModel;

  final int _scanTimeout = 15;

  late BluetoothConnectionState _bluetoothConnectionState;
  late BluetoothCharacteristic? _selectedCharacteristic;

  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  late final _circleColorPickerController;

  @override
  void initState() {
    super.initState();

    _isScanning = false;
    _selectedDeviceIndex = 0;
    _circleColorPickerController = CircleColorPickerController();

    _bluetoothConnectionState = BluetoothConnectionState.disconnected;
    _selectedCharacteristic = null;

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
          (results) {
        _scanResults = results;
        if (mounted) setState(() {});
      },
      onError: (e) => toastMsg(msg: 'Error scan result subscription: $e'),
    );

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      if (mounted) setState(() => _isScanning = state);
    });

    scanDevice();
  }

  @override
  void dispose() {
    disconnectDevice();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    _circleColorPickerController.dispose();
    super.dispose();
  }

  Future scanDevice() async {
    _scanResults.clear();

    try {
      int divisor = Platform.isAndroid ? 8 : 1;
      await FlutterBluePlus.startScan(
        timeout: Duration(seconds: _scanTimeout),
        continuousUpdates: true,
        continuousDivisor: divisor,
      );
    } catch (e) {
      toastMsg(msg: 'Error scan device method: $e');
    }
  }

  Future<void> disconnectDevice() async {
    try {
      if (_selectedDeviceIndex < _scanResults.length) {
        await _scanResults[_selectedDeviceIndex].device.disconnect();
        toastMsg(msg: 'Device disconnected successfully.');
      }
    } catch (e) {
      toastMsg(msg: 'Error disconnecting device: $e');
    }
  }

  Future getCharacteristic() async {
    List<BluetoothService> services =
    await _scanResults[_selectedDeviceIndex].device.discoverServices();

    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == mCharacteristicUuid) {
          _selectedCharacteristic = characteristic;
        }
      }
    }
  }

  void toastMsg({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: CupertinoColors.systemGreen,
    );
  }

  Future bleRead() async {
    if (_selectedCharacteristic == null) {
      toastMsg(msg: 'No characteristic selected.');
      return;
    }

    try {
      await _selectedCharacteristic!.read().then((value) {
        setState(() {
          _ledModel = LedModel(
            isLedOn: value[0] == 1,
            selectedAnimation: HexDecConverter.convertAnimationHexToDec(value[1]),
            brightnessValue: value[2],
            ledRed: value[3],
            ledGreen: value[4],
            ledBlue: value[5],
          );

          _bluetoothConnectionState = BluetoothConnectionState.connected;
        });
      });
    } catch (e) {
      toastMsg(msg: 'Error reading characteristic: $e');
    }
  }

  Future bleWrite(List<int> list) async {
    _bluetoothConnectionState == BluetoothConnectionState.connected
        ? await _selectedCharacteristic!.write(Uint8List.fromList(list))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0, backgroundColor: TColors.primary100,),
      body: Container(
        color: TColors.primary100,
        child:
          _bluetoothConnectionState == BluetoothConnectionState.disconnected
              ? ScanBleDevicePage(

            isScanning: _isScanning,
            scanResults: _scanResults,
            timerValue: _scanTimeout,
            connect: (index) async {
              if (_scanResults.isEmpty) {
                toastMsg(msg: 'No devices available to connect.');
                return;
              }

              setState(() => _selectedDeviceIndex = index);
              try {
                await _scanResults[_selectedDeviceIndex].device.connect().then((value) => getCharacteristic());
                await bleRead();
                toastMsg(
                    msg: '${_scanResults[_selectedDeviceIndex].device.platformName} connected');
              } catch (e) {
                toastMsg(msg: 'Error connecting to device: $e');
              }
            },
          )
              : ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              // const Gap(homeSizedHeight),
              LedStatusWidget(
                isLedOn: _ledModel.isLedOn,
                changeStatus: (p0) async {
                  await bleWrite([0x02, _ledModel.isLedOn ? 0x00 : 0x01]);
                  setState(() => _ledModel.isLedOn = p0);
                },
              ),
              AnimationWidget(
                selectedAnimation: (p0) async {
                  setState(() => _ledModel.selectedAnimation = p0);
                  await bleWrite([
                    0x09,
                    HexDecConverter.convertAnimationDecToHex(
                        _ledModel.selectedAnimation)
                  ]);
                },
                selectedIndex: _ledModel.selectedAnimation,
              ),
              LedBrightness(
                changeBrightnessEnd: (p0) async {
                  await bleWrite([
                    0x20,
                    int.parse(HexDecConverter.convertDecimalToHex(
                        _ledModel.brightnessValue))
                  ]);
                },
                changeBrightness: (p0) {
                  setState(() => _ledModel.brightnessValue = p0);
                },
                currentValue: _ledModel.brightnessValue,
              ),
              _ledModel.selectedAnimation == 0 ||
                  _ledModel.selectedAnimation == 4
                  ? Column(
                children: [
                  LedReadyColor(
                    selectedColor: (p0) async {
                      await bleWrite(
                        [
                          0x10,
                          HexDecConverter.convertDecToHex(
                              colorList[p0].red),
                          HexDecConverter.convertDecToHex(
                              colorList[p0].green),
                          HexDecConverter.convertDecToHex(
                              colorList[p0].blue),
                        ],
                      );
                    },
                  ),
                  LightColorPicker(
                    circleColorPickerController:
                    _circleColorPickerController,
                    onEnded: (p0) async {
                      await bleWrite([
                        0x10,
                        HexDecConverter.convertDecToHex(p0.red),
                        HexDecConverter.convertDecToHex(p0.green),
                        HexDecConverter.convertDecToHex(p0.blue),
                      ]);
                    },
                    onChanged: (p0) {
                      setState(() {
                        _circleColorPickerController.color = p0;
                      });
                    },
                  ),
                ],
              )
                  : const SizedBox.shrink(),
              const SizedBox(height: 50),
              // const Gap(homeSizedHeight * 2.5),
            ],
          ),
      ),
    );
  }
}