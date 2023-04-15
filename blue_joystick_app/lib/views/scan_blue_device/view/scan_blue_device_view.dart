import 'package:flutter/material.dart';
import '../cubit/scan_blue_device_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'scan_blue_device_page.dart';

class ScanBlueDeviceView extends StatelessWidget {
  const ScanBlueDeviceView({super.key});
  static const String routeName = '/scan_blue_device_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanBlueDeviceCubit()
        ..init(),
      child: const ScanBlueDevicePage(),
    );
  }
}
