import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Check permission
  /// - Permission status != granted -> request
  /// - Return `Future<bool>`
  ///
  /// Example:
  /// ```dart
  /// final cameraPermission = await PermissionService.checkAndRequestPermission(Permission.camera)
  /// print(cameraPermission) //true
  /// ```
  static Future<bool> checkAndRequestPermission(Permission permission) async {
    bool result = false;

    var statusPermission = await permission.status;

    if (statusPermission != PermissionStatus.granted) {
      statusPermission = await permission.request();
    }

    if (statusPermission == PermissionStatus.granted) {
      result = true;
    }

    return result;
  }

  /// check Device Enable or Disabled Location
  static Future<bool> isEnableLocation() async =>
      await Permission.locationWhenInUse.serviceStatus.isEnabled;

  /// check Device Enable or Disabled Bluetooth
  static Future<bool> isEnableBluetooth() async =>
      await FlutterBluePlus.instance.isOn;

  /// check and request Bluetooth Permission
  static Future<bool> bluetoothPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 30) {
        return await checkAndRequestPermission(Permission.bluetooth);
      } else {
        PermissionStatus permission = await Permission.bluetoothScan.status;
        if (permission != PermissionStatus.granted) {
          Map<Permission, PermissionStatus> permissions = await [
            Permission.bluetoothScan,
            Permission.bluetoothConnect
          ].request();
          if (permissions[Permission.bluetoothScan] ==
                  PermissionStatus.granted &&
              permissions[Permission.bluetoothConnect] ==
                  PermissionStatus.granted) {
            return true;
          }
          return false;
        } else {
          return true;
        }
      }
    } else {
      return await checkAndRequestPermission(Permission.bluetooth);
    }
  }

  /// Kiểm tra quyền bộ nhớ
  static Future<bool> checkPermissionStorage() async {
    return await checkAndRequestPermission(Permission.storage);
  }

  /// Kiểm tra quyền vị trí
  static Future<bool> checkPermissionLocation() async {
    return await checkAndRequestPermission(Permission.location);
  }

  /// Kiểm tra quyền pick ảnh ở thư viện
  static Future<bool> checkPermissionGallery() async {
    if (Platform.isAndroid) {
      return await checkAndRequestPermission(Permission.storage);
    } else if (Platform.isIOS) {
      return await checkAndRequestPermission(Permission.photos);
    }

    return false;
  }

  /// Kiểm tra quyền camera
  static Future<bool> checkPermissionCamera() async {
    return await checkAndRequestPermission(Permission.camera);
  }
}
