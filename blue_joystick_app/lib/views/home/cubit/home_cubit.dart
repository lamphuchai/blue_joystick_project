// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blue_joystick/models/models.dart';
import 'package:blue_joystick/services/permission_service.dart';
import 'package:blue_joystick/widgets/app_setting_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blue_joystick/services/blue_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            buttonValue: ButtonValue.init(),
            isConnect: false,
            permission: TypeDialog.none));
  final BlueService _blueService = BlueService.instance;
  late final StreamSubscription? _deviceConnectedStreamSubscription;

  JoystickValue _joystickValue = JoystickValue.init();

  bool showDialog = false;

  Future<bool> checkPermission() async {
    emit(state.copyWith(permission: TypeDialog.none));
    if (!await PermissionService.isEnableBluetooth()) {
      emit(state.copyWith(permission: TypeDialog.bluetooth));
      return false;
    }
    if (!await PermissionService.bluetoothPermission()) {
      emit(state.copyWith(permission: TypeDialog.permissionBlue));
      return false;
    }
    if (!await PermissionService.isEnableLocation()) {
      emit(state.copyWith(permission: TypeDialog.enableLocation));
      return false;
    }
    if (!await PermissionService.checkPermissionLocation()) {
      emit(state.copyWith(permission: TypeDialog.permissionLocation));
      return false;
    }

    return true;
  }

  void initBlue() async {
    if (await checkPermission()) {
      _blueService.connectedDevice();
      _deviceConnectedStreamSubscription =
          _blueService.deviceConnected.listen((device) {
        switch (device.type) {
          case BluetoothDeviceState.connected:
            emit(state.copyWith(isConnect: true));
            break;

          default:
            emit(state.copyWith(isConnect: false));

            break;
        }
      });
    }
  }

  void sendMessage(String message) {
    _blueService.send(message);
  }

  sendXValue(double x) {
    double xValue = double.parse(x.toStringAsFixed(1));
    if (_joystickValue.compareXAxisValue(xValue)) {
      final newValue = _joystickValue.copyWith(x: xValue);
      if (newValue != _joystickValue) {
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          _blueService.send(_joystickValue.messageBlue());
          // xValue.log(tag: "xValue");
        });
        _joystickValue = newValue;
      }
    }
  }

  sendYValue(double y) {
    y = y == 0 ? 0 : -y;
    double yValue = double.parse(y.toStringAsFixed(1));
    if (_joystickValue.compareYAxisValue(yValue)) {
      final newValue = _joystickValue.copyWith(y: yValue);
      if (newValue != _joystickValue) {
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          _blueService.send(_joystickValue.messageBlue());
          // yValue.log(tag: "yValue");
        });
        _joystickValue = newValue;
      }
    }
  }

  String? getNameDeviceConnected() {
    return _blueService.currentDeviceConnected?.name;
  }

  void changeButtonValue(ButtonValue value) {
    emit(state.copyWith(buttonValue: value));
    // Gửi giá trị của button qua bluetooth
    _blueService.send(value.messageBlue());
  }

  @override
  Future<void> close() {
    _deviceConnectedStreamSubscription?.cancel();
    return super.close();
  }
}
