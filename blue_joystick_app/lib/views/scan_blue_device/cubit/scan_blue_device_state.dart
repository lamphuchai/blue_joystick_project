// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'scan_blue_device_cubit.dart';

class ScanBlueDeviceState extends Equatable {
  const ScanBlueDeviceState(
      {this.listScanDevice = const [], this.status = ActionStatus.init,required this.deviceConnected });
  final List<BluetoothDevice> listScanDevice;

  final ActionStatus status;
  final BluetoothDevice deviceConnected;

  @override
  List<Object> get props => [listScanDevice, status,deviceConnected];

  ScanBlueDeviceState copyWith({
    List<BluetoothDevice>? listScanDevice,

    ActionStatus? status,
     BluetoothDevice? deviceConnected

  }) {
    return ScanBlueDeviceState(
      listScanDevice: listScanDevice ?? this.listScanDevice,

      status: status ?? this.status,
      deviceConnected: deviceConnected ?? this.deviceConnected
    );
  }
}
