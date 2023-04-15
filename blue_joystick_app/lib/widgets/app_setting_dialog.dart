import 'package:app_settings/app_settings.dart';
import 'package:blue_joystick/app/constants.dart';
import 'package:blue_joystick/app/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';

enum TypeDialog {
  none,
  permissionBlue,
  permissionLocation,
  bluetooth,
  enableLocation,
  wifi
}

class AppSettingDialog extends StatelessWidget {
  const AppSettingDialog({super.key, required this.type});
  final TypeDialog type;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTextTheme;
    return CustomDialog(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.paddingScaffold),
        child: SizedBox(
          width: context.width * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.translate(title),
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Text(
                context.translate(content),
                style: textTheme.bodyMedium!.copyWith(height: 1.3),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16)),
                  onPressed: () {
                    openAppSetting();
                    Navigator.pop(context, true);
                  },
                  child: Text(titleButton)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String get title {
    switch (type) {
      case TypeDialog.permissionBlue:
        // return "DIALOG.PERMISSION_SCAN";
        return "Tìm kiếm thiết bị xung quanh";
      case TypeDialog.permissionLocation:
        // return "DIALOG.PERMISSION_LOCATION";
        return 'Ứng dụng cần quyền truy cập vị trí';
      case TypeDialog.bluetooth:
        // return "DIALOG.YOU_DO_NOT_ON_BLUETOOTH";
        return "Thiết bị chưa bật bluetooth";
      case TypeDialog.enableLocation:
        // return "DIALOG.LOCATION";
        return "Thiết bị chưa bật vị trí";
      case TypeDialog.wifi:
        return "DIALOG.WIFI";
      default:
        return "";
    }
  }

  String get content {
    switch (type) {
      case TypeDialog.permissionBlue:
        // return "DIALOG.PERMISSION_SCAN_MESSAGE";
        return 'Ứng dụng cần quyền truy cập bluetooth để tìm kiếm thiết bị xung quanh';
      case TypeDialog.permissionLocation:
        // return "DIALOG.PERMISSION_LOCATION_MESSAGE";
        return 'Ứng dụng cần quyền truy cập vị trí để tìm kiếm thiết bị xung quanh';
      case TypeDialog.bluetooth:
        // return "DIALOG.BLUETOOTH_MESSAGE";
        return 'Để tìm kiếm thiết bị xung quanh, Ứng dụng cần sử dụng bluetooth. Bạn cần bật bluetooth trên thiết bị';
      case TypeDialog.enableLocation:
        // return "DIALOG.LOCATION_MESSAGE";
        return 'Ứng dụng cần quyền truy cập vị trí để tìm kiếm thiết bị xung quanh';
      case TypeDialog.wifi:
        return "DIALOG.WIFI_MESSAGE";
      default:
        return "";
    }
  }

  String get titleButton {
    switch (type) {
      case TypeDialog.bluetooth:
        // return 'DIALOG.TURN_ON_BLUETOOTH';
        return "Bật bluetooth";
      default:
        // return 'DIALOG.GO_SETTING';
        return 'Đi đến cài đặt';
    }
  }

  void openAppSetting() {
    switch (type) {
      case TypeDialog.bluetooth:
        AppSettings.openBluetoothSettings();
        break;
      default:
        AppSettings.openAppSettings();

        break;
    }
  }
}
