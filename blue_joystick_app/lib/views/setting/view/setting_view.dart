import 'package:flutter/material.dart';
import '../cubit/setting_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_page.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
  static const String routeName = '/setting_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: const SettingPage(),
    );
  }
}
