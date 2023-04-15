import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ButtonValue {
  final bool button1;
  final bool button2;
  final bool button3;
  final bool buttonDefault;
  ButtonValue({
    required this.button1,
    required this.button2,
    required this.button3,
    required this.buttonDefault,
  });

  factory ButtonValue.init() => ButtonValue(
      button1: false, button2: false, button3: false, buttonDefault: false);

  ButtonValue copyWith({
    bool? button1,
    bool? button2,
    bool? button3,
    bool? buttonDefault,
  }) {
    return ButtonValue(
      button1: button1 ?? this.button1,
      button2: button2 ?? this.button2,
      button3: button3 ?? this.button3,
      buttonDefault: buttonDefault ?? this.buttonDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'button1': button1,
      'button2': button2,
      'button3': button3,
      'buttonDefault': buttonDefault,
    };
  }

  factory ButtonValue.fromMap(Map<String, dynamic> map) {
    return ButtonValue(
      button1: map['button1'] as bool,
      button2: map['button2'] as bool,
      button3: map['button3'] as bool,
      buttonDefault: map['buttonDefault'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  String messageBlue() {
    final result = {"button": toMap()};
    return json.encode(result);
  }

  factory ButtonValue.fromJson(String source) =>
      ButtonValue.fromMap(json.decode(source) as Map<String, dynamic>);
}
