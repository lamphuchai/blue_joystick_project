import 'package:blue_joystick/app/extensions/context_extension.dart';
import 'package:blue_joystick/widgets/app_setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cubit/home_cubit.dart';
import '../widget/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late HomeCubit homeCubit;

  late FToast _fToast;

  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    _fToast = FToast().init(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      homeCubit.initBlue();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: context.appTheme.colorScheme.background,
      body: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
              listenWhen: (previous, current) =>
                  previous.isConnect != current.isConnect,
              listener: (context, state) {
                if (homeCubit.showDialog) return;
                if (state.isConnect) {
                  _fToast.showToast(child: const Text("Kết nối thành công"));
                } else {
                  _fToast.showToast(child: const Text("Ngắt kết nối"));
                }
              }),
          BlocListener<HomeCubit, HomeState>(
              listenWhen: (previous, current) =>
                  previous.permission != current.permission,
              listener: (context, state) {
                if (state.permission != TypeDialog.none) {
                  showDialog(
                          context: context,
                          builder: (_) =>
                              AppSettingDialog(type: state.permission))
                      .then((value) {
                    if (value == null) {
                      homeCubit.initBlue();
                    }
                  });
                }
              })
        ],
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          final buttons = state.buttonValue;
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  homeCubit.changeButtonValue(buttons
                                      .copyWith(button1: !buttons.button1));
                                },
                                child: Container(
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: buttons.button1
                                          ? colors.primary
                                          : colors.surface),
                                  child: Text(
                                    "1",
                                    style: context.appTextTheme.bodySmall,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  homeCubit.changeButtonValue(buttons
                                      .copyWith(button2: !buttons.button2));
                                },
                                child: Container(
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: buttons.button2
                                          ? colors.primary
                                          : colors.surface),
                                  child: Text(
                                    "2",
                                    style: context.appTextTheme.bodySmall,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  homeCubit.changeButtonValue(buttons
                                      .copyWith(button3: !buttons.button3));
                                },
                                child: Container(
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: buttons.button3
                                          ? colors.primary
                                          : colors.surface),
                                  child: Text(
                                    "3",
                                    style: context.appTextTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        String textString = "Không có kết nối";
                        if (state.isConnect) {
                          textString = homeCubit.getNameDeviceConnected() ??
                              "Thiết bị";
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              homeCubit.showDialog = true;
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const BlueDeviceDialog()).then((value) {
                                homeCubit.showDialog = false;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: state.isConnect
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(textString)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Expanded(
                      child: SizedBox(),
                      // child: Align(
                      //   alignment: Alignment.centerRight,
                      //   child: IconButton(
                      //       onPressed: () {
                      //         // Navigator.pushNamed(context, RouteNames.setting);
                      //         showDialog(
                      //             context: context,
                      //             builder: (context) => AppSettingDialog(
                      //                 onOpen: () {},
                      //                 type: TypeDialog.enableLocation));
                      //       },
                      //       icon: const Icon(Icons.settings)),
                      // ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Joystick(
                        mode: JoystickMode.vertical,
                        stickOffsetCalculator:
                            const CircleStickOffsetCalculator(),
                        listener: (details) {
                          homeCubit.sendYValue(details.y);
                        },
                        stick: const StickWidget(),
                      ),
                    )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                            // buildWhen: (previous, current) =>
                            //     previous.buttonValue.buttonDefault !=
                            //     current.buttonValue.buttonDefault,
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  homeCubit.changeButtonValue(
                                      state.buttonValue.copyWith(
                                          buttonDefault: !state
                                              .buttonValue.buttonDefault));
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: state.buttonValue.buttonDefault
                                        ? colors.primary
                                        : colors.surface,
                                  ),
                                  child: const Icon(Icons.light_mode),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Joystick(
                        mode: JoystickMode.horizontal,
                        stickOffsetCalculator:
                            const CircleStickOffsetCalculator(),
                        listener: (details) {
                          homeCubit.sendXValue(details.x);
                        },
                        stick: const StickWidget(),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
