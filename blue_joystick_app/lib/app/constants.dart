import 'package:flutter/material.dart';

class Constants {
  static const double paddingScaffold = 16.0;
  static const double paddingContent = 10.0;
  static const double radius = 10.0;
  static const double cardElevation = 0.3;

  static final borderRadius = BorderRadius.circular(radius);
  static const double radiusModalBottomSheet = 21;

  static const double buttonLarge = 53.0;
  static const double buttonMedium = 40.0;
  static const double buttonSmall = 32.0;
  static const EdgeInsets paddingPage =
      EdgeInsets.symmetric(horizontal: paddingScaffold);

  static final shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  static const listRoomRecommend = [
    "LIVING_ROOM",
    "BEDROOM",
    "KITCHEN",
    "BATHROOM",
    "STUDY",
    "DINING_ROOM",
    "GARAGE",
    "OTHER",
  ];

  static String getRoomName(String roomName) {
    if (roomName == "favorite") {
      return 'ROOM.FAVORITE';
    }
    final check = listRoomRecommend.contains(roomName);
    if (check) {
      return 'ROOM.$roomName';
    }
    return roomName;
  }
}
