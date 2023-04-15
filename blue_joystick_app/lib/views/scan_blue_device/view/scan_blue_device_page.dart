import 'package:blue_joystick/app/constants.dart';
import 'package:blue_joystick/app/extensions/context_extension.dart';
import 'package:blue_joystick/app/extensions/log_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cubit/scan_blue_device_cubit.dart';

class ScanBlueDevicePage extends StatefulWidget {
  const ScanBlueDevicePage({super.key});

  @override
  State<ScanBlueDevicePage> createState() => _ScanBlueDevicePageState();
}

class _ScanBlueDevicePageState extends State<ScanBlueDevicePage> {
  late final ScanBlueDeviceCubit _scanBlueDeviceCubit;
  late FToast fToast;

  @override
  void initState() {
    _scanBlueDeviceCubit = context.read<ScanBlueDeviceCubit>();
    fToast = FToast().init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
          centerTitle: true,
          title: const Text("Thiết bị xung quanh"),
          actions: [
            IconButton(
                onPressed: _scanBlueDeviceCubit.startScanBlue,
                icon: const Icon(Icons.loop)),
          ],
        ),
        body: BlocListener<ScanBlueDeviceCubit, ScanBlueDeviceState>(
          listenWhen: (previous, current) =>
              previous.deviceConnected.id != current.deviceConnected.id,
          listener: (context, state) {
            // state.deviceConnected.id.log();
            final message = state.deviceConnected.id.toString() == "0"
                ? "Ngắt kết nối thành công"
                : "Kết nối thành công";
            fToast.showToast(child: Text(message));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ScanBlueDeviceCubit, ScanBlueDeviceState>(
                  builder: (context, state) {
                    if (state.deviceConnected.id.toString() == "0") {
                      return const SizedBox();
                    }
                    return ListTile(
                      tileColor: context.colors.surface,
                      shape: RoundedRectangleBorder(
                          borderRadius: Constants.borderRadius),
                      title: Text(state.deviceConnected.name),
                      trailing: GestureDetector(
                        onTap: _scanBlueDeviceCubit.disconnect,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: ShapeDecoration(
                                shape: const StadiumBorder(),
                                color: context.colors.error.withOpacity(0.7)),
                            child: const Text("Ngắt kết nối")),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<ScanBlueDeviceCubit, ScanBlueDeviceState>(
                    builder: (context, state) {
                      return ListView.builder(
                          itemCount: state.listScanDevice.length,
                          itemBuilder: (_, index) {
                            final device = state.listScanDevice[index];
                            if (device.name == "" &&
                                device.type != BluetoothDeviceType.le &&
                                device.id == state.deviceConnected.id) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                tileColor: context.colors.surface,
                                shape: RoundedRectangleBorder(
                                    borderRadius: Constants.borderRadius),
                                title: Text(device.name),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _scanBlueDeviceCubit.connect(device);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: const ShapeDecoration(
                                          shape: StadiumBorder(),
                                          color: Colors.green),
                                      child: const Text("Kết nối")),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
