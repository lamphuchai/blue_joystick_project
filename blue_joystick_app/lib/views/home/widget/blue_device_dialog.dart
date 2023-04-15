import 'package:blue_joystick/app/extensions/context_extension.dart';
import 'package:blue_joystick/views/scan_blue_device/scan_blue_device.dart';
import 'package:flutter/material.dart';

class BlueDeviceDialog extends StatelessWidget {
  const BlueDeviceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
          width: context.width * 0.55, child: const ScanBlueDeviceView()),
    );
  }
}
