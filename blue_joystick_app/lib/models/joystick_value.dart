import 'dart:convert';

class JoystickValue {
  double x;
  double y;
  JoystickValue({
    required this.x,
    required this.y,
  });

  factory JoystickValue.init() => JoystickValue(x: 0, y: 0);

  JoystickValue copyWith({
    double? x,
    double? y,
  }) {
    return JoystickValue(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  bool compareXAxisValue(double value) {
    if (value == x) return false;
    return true;
  }

  bool compareYAxisValue(double value) {
    if (value == y) return false;
    return true;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory JoystickValue.fromMap(Map<String, dynamic> map) {
    return JoystickValue(
      x: map['x'] as double,
      y: map['y'] as double,
    );
  }

  String toJson() => json.encode(toMap());
  String messageBlue() {
    final result = {"joystick": toMap()};
    return json.encode(result);
  }

  factory JoystickValue.fromJson(String source) =>
      JoystickValue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant JoystickValue other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
