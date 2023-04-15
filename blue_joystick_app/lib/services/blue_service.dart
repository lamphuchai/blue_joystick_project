// ignore_for_file: unused_field, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:blue_joystick/app/extensions/log_extension.dart';
import 'package:blue_joystick/services/permission_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const String SERVICE_UUID = "713D0000-503E-4C75-BA94-3148F18D941E";
// dùng để gửi message
const String CHARACTERISTIC_UUID_TX = "713D0002-503E-4C75-BA94-3148F18D941E";

// dùng để nhận message từ thiết bị được kết nối
// fix lỗi characteristic.setNotifyValue  characteristic bắt buộc 0003
const String CHARACTERISTIC_UUID_RX = "713D0003-503E-4C75-BA94-3148F18D941E";

class StatusDevice {
  final BluetoothDeviceState type;
  final BluetoothDevice device;

  const StatusDevice({required this.device, required this.type});
}

class BlueService {
  BlueService._();
  static final BlueService _instance = BlueService._();
  static BlueService get instance => _instance;
  final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  Stream<List<ScanResult>> get resultScan => _flutterBlue.scanResults;
  Stream<bool> get isScanning => _flutterBlue.isScanning;

  FlutterBluePlus get flutterBlue => _flutterBlue;

  /// Thiết bị đang kết nối
  BluetoothDevice? currentDeviceConnected;

  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();
  Stream<String> get message => _messageStreamController.stream;

  final StreamController<StatusDevice> _deviceConnectedStreamController =
      StreamController<StatusDevice>.broadcast();
  Stream<StatusDevice> get deviceConnected =>
      _deviceConnectedStreamController.stream;

  StreamSubscription? _streamDeviceState;
  StreamSubscription? _streamCharacteristic;

  bool isConnect = false;
  BluetoothCharacteristic? _writeCharacteristic;
  BluetoothCharacteristic? _readAndNotifyCharacteristic;

  BluetoothDeviceState? _deviceStatus;

  // get list device connected
  Future<List<BluetoothDevice>> get connectedDevices =>
      _flutterBlue.connectedDevices;

  Future<bool> checkPermission({bool? showDialog = false}) async {
    bool result = false;
    if (!await PermissionService.isEnableBluetooth()) {
      
    }
    if (!await PermissionService.bluetoothPermission()) {}
    if (!await PermissionService.isEnableLocation()) {}
    if (!await PermissionService.checkPermissionLocation()) {}
    return result;
  }

  void connectedDevice() async {
    if (await checkPermission(showDialog: false)) {
      final devices = await connectedDevices;

      if (devices.isNotEmpty &&
          currentDeviceConnected?.id != devices.first.id) {
        "ConnectedDevice::: ${devices.first.name}".log(tag: "connectedDevice");
        listenDataDevice(devices.first);
      }
    }
  }

  Future<bool> startScan(
      {Duration timeout = const Duration(seconds: 10)}) async {
    try {
      await _flutterBlue.startScan(
          timeout: timeout, scanMode: ScanMode.lowPower);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> stopScan() async {
    try {
      await _flutterBlue.stopScan();
      return true;
    } catch (error) {
      error.log(tag: "stopScan");
      return false;
    }
  }

  Future<void> connect(BluetoothDevice device) async {
    try {
      if (isConnect) {
        currentDeviceConnected?.disconnect();
      }
      await device.connect(autoConnect: true);
      "connect ${device.name}".log(tag: "Device");
      _flutterBlue.setLogLevel(LogLevel.info);
      listenDataDevice(device);
    } catch (error) {
      error.log(tag: "error connect device");
      rethrow;
    }
  }

  void listenDataDevice(BluetoothDevice device) {
    if (_streamDeviceState != null) _streamDeviceState?.cancel();
    _streamDeviceState = device.state.listen((onData) async {
      _deviceStatus = onData;
      _deviceConnectedStreamController
          .add(StatusDevice(device: device, type: onData));
      "DeviceState ${onData.name}".log(tag: "_streamDeviceState");

      switch (onData) {
        case BluetoothDeviceState.connected:
          "connect ${device.name}".log(tag: "listenDataDevice");
          isConnect = true;
          currentDeviceConnected = device;
          _messageStreamController.add("CONNECT");
          List<BluetoothService> services = await device.discoverServices();
          services.forEach((service) async {
            if (service.uuid.toString().toUpperCase() == SERVICE_UUID) {
              service.characteristics.forEach((characteristic) async {
                switch (characteristic.uuid.toString().toUpperCase()) {
                  case CHARACTERISTIC_UUID_RX:
                    "setNotifyValue $CHARACTERISTIC_UUID_RX"
                        .log(tag: "listenDataDevice");
                    try {
                      await characteristic.setNotifyValue(true);
                    } catch (error) {
                      error.log(tag: "setNotifyValue");
                    }
                    _readAndNotifyCharacteristic = characteristic;
                    "setReadAndNotifyCharacteristic $CHARACTERISTIC_UUID_RX"
                        .log(tag: "listenDataDevice");
                    if (_streamCharacteristic != null) {
                      _streamCharacteristic?.cancel();
                    }
                    _streamCharacteristic =
                        characteristic.value.listen((value) {
                      if (value.isNotEmpty) {
                        String.fromCharCodes(value)
                            .log(tag: "Bluetooth message");
                        _messageStreamController
                            .add(String.fromCharCodes(value));
                      }
                    });
                    break;
                  case CHARACTERISTIC_UUID_TX:
                    "setWriteCharacteristic $CHARACTERISTIC_UUID_TX"
                        .log(tag: "listenDataDevice");
                    _writeCharacteristic = characteristic;
                    break;
                  default:
                    break;
                }
              });
            }
          });
          break;
        default:
          currentDeviceConnected = null;
          isConnect = false;
          break;
      }
    });
  }

  void disconnect() async {
    if (_deviceStatus != null &&
        _deviceStatus == BluetoothDeviceState.connected) {
      await currentDeviceConnected?.disconnect();
    }
    isConnect = false;
    _writeCharacteristic = null;
  }

  void send(String message) async {
    message.log(tag: "message to blue");
    try {
      if (_deviceStatus != null &&
          _deviceStatus == BluetoothDeviceState.connected) {
        "send message to blue".log(tag: "Blue Service");
        await _writeCharacteristic?.write(utf8.encode(message));
      }
    } catch (error) {
      "send error".log(tag: "Blue Service");
    }
  }

  close() {
    _streamCharacteristic?.cancel();
    _messageStreamController.close();
    _deviceConnectedStreamController.close();
    _streamDeviceState?.cancel();
  }
}
