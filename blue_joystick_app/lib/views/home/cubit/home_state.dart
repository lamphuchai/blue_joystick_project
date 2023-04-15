// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.isConnect = false,
      required this.buttonValue,
      required this.permission});
  final bool isConnect;
  final ButtonValue buttonValue;
  final TypeDialog permission;
  @override
  List<Object> get props => [isConnect, buttonValue, permission];

  HomeState copyWith(
      {bool? isConnect, ButtonValue? buttonValue, TypeDialog? permission}) {
    return HomeState(
        isConnect: isConnect ?? this.isConnect,
        buttonValue: buttonValue ?? this.buttonValue,
        permission: permission ?? this.permission);
  }
}
