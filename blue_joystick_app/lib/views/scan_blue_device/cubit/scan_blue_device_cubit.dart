import 'dart:async';
import 'package:blue_joystick/app/app_types.dart';
import 'package:blue_joystick/services/blue_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'scan_blue_device_state.dart';

class ScanBlueDeviceCubit extends Cubit<ScanBlueDeviceState> {
  ScanBlueDeviceCubit()
      : super(
            ScanBlueDeviceState(deviceConnected: BluetoothDevice.fromId("0"))) {
    _scanDeviceStreamSubscription = blueService.resultScan.listen((result) {
      final deviceCurrent = state.deviceConnected;
      final devices = result
          .where(((element) =>
              element.device.name != "" &&
              deviceCurrent.id != element.device.id))
          .map((e) => e.device)
          .toList();
      emit(state.copyWith(listScanDevice: devices));
    });
    _isScanStreamSubscription = blueService.isScanning.listen((event) {
      isScan = event;
    });
    _deviceConnectedStreamSubscription =
        blueService.deviceConnected.listen((device) {
      switch (device.type) {
        case BluetoothDeviceState.connected:
          final lstTmp = state.listScanDevice
              .where(
                (element) => element.id != device.device.id,
              )
              .toList();
          emit(state.copyWith(
              deviceConnected: device.device, listScanDevice: lstTmp));
          break;
        default:
          emit(state.copyWith(
            deviceConnected: BluetoothDevice.fromId("0"),
          ));
          blueService.startScan(timeout: const Duration(seconds: 5));
          break;
      }
    });
  }
  final BlueService blueService = BlueService.instance;

  late final StreamSubscription _scanDeviceStreamSubscription;
  late final StreamSubscription _isScanStreamSubscription;
  late final StreamSubscription _deviceConnectedStreamSubscription;

  bool isScan = false;

  void init() {
    if (blueService.currentDeviceConnected != null) {
      emit(state.copyWith(deviceConnected: blueService.currentDeviceConnected));
    }
    // blueService.connectedDevice();
    startScanBlue();
  }

  void startScanBlue() {
    blueService.startScan();
  }

  void connect(BluetoothDevice device) => blueService.connect(device);
  void disconnect() => blueService.disconnect();

  @override
  Future<void> close() async {
    if (isScan) {
      await blueService.stopScan();
    }
    _scanDeviceStreamSubscription.cancel();
    _isScanStreamSubscription.cancel();
    _deviceConnectedStreamSubscription.cancel();
    return super.close();
  }
}
