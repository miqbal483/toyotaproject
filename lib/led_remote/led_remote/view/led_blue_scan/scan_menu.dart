import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mobile_app/core/constants/app_color.dart';
import '../../constant/size.dart';
import '../../theme/menu_theme.dart';
import '../../navigation/head_widget.dart';

class ScanBleDevicePage extends StatelessWidget {
  const ScanBleDevicePage({
    super.key,
    required this.scanResults,
    required this.connect,
    required this.isScanning,
    required this.timerValue,
  });

  final List<ScanResult> scanResults;
  final Function(int) connect;
  final bool isScanning;
  final int timerValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildScanningStatus(),
            const Divider(),
            Expanded(child: _buildDeviceList()),
          ],
        ),
      ),
    );
  }

  Widget _buildScanningStatus() {
    if (isScanning) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LinearProgressIndicator(
            color: CupertinoColors.inactiveGray,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeadWidget(title: 'Scanning Bluetooth Devices...'),
              TweenAnimationBuilder(
                tween: Tween(begin: timerValue, end: 0.0),
                duration: Duration(seconds: timerValue),
                builder: (_, dynamic value, child) => Text(
                  "${value.toInt()} sec",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: headSize,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return const HeadWidget(title: 'Devices found');
    }
  }

  Widget _buildDeviceList() {
    if (scanResults.isEmpty) {
      return const Center(
        child: Text(
          'No devices found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: scanResults.length,
      itemBuilder: (context, index) {
        final device = scanResults[index].device;
        final rssi = scanResults[index].rssi;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),

          decoration: BoxDecoration(
            color: _determineCardColor(device.platformName),
            borderRadius: BorderRadius.circular(22),
          ),
          child: ListTile(
            leading: Icon(
              device.platformName.isEmpty
                  ? Icons.do_not_disturb_alt
                  : Icons.devices_outlined,
            ),
            title: Text(
              device.platformName.isEmpty ? 'Unknown Device' : device.platformName,
            ),
            subtitle: Text(
              '$rssi dBm',
              style: _computeTextStyle(rssi),
            ),
            trailing: TextButton(
              onPressed: device.platformName.isEmpty ? null : () => connect(index),
              child: Text(
                device.platformName.isEmpty ? 'Not Connectable' : 'Connect',
                style: TextStyle(
                  color: device.platformName.isEmpty
                      ? CupertinoColors.systemGrey
                      : CupertinoColors.systemGreen,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _determineCardColor(String platformName) {
    return platformName.isEmpty
        ? colorCard?.withOpacity(0.5) ?? Colors.grey[300]!
        : colorCard ?? Colors.white;
  }

  static TextStyle _computeTextStyle(int rssi) {
    if (rssi >= -35) {
      return TextStyle(color: Colors.greenAccent[700]!.withOpacity(0.5));
    } else if (rssi >= -45) {
      return TextStyle(
          color: Color.lerp(Colors.greenAccent[700]!.withOpacity(0.5),
              Colors.lightGreen.withOpacity(0.5), -(rssi + 35) / 10));
    } else if (rssi >= -55) {
      return TextStyle(
          color: Color.lerp(Colors.lightGreen.withOpacity(0.5),
              Colors.lime[600]!.withOpacity(0.5), -(rssi + 45) / 10));
    } else if (rssi >= -65) {
      return TextStyle(
          color: Color.lerp(Colors.lime[600]!.withOpacity(0.5),
              Colors.amber.withOpacity(0.5), -(rssi + 55) / 10));
    } else if (rssi >= -75) {
      return TextStyle(
          color: Color.lerp(Colors.amber.withOpacity(0.5),
              Colors.deepOrangeAccent.withOpacity(0.5), -(rssi + 65) / 10));
    } else if (rssi >= -85) {
      return TextStyle(
          color: Color.lerp(Colors.deepOrangeAccent.withOpacity(0.5),
              Colors.redAccent.withOpacity(0.5), -(rssi + 75) / 10));
    } else {
      return TextStyle(color: Colors.redAccent.withOpacity(0.5));
    }
  }
}